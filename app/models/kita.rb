class Kita < ActiveRecord::Base
  acts_as_mappable
  
  # VALIDATIONS
  validates_presence_of :name, :data_origin
  # FIXME this validation seems to fail, we still have doubles in the db
  validates_uniqueness_of :lat, :scope => :lng, :if => :geocoded?
  
  def self.search(_from, _page)
    return Kita.paginate(:all, :page => _page, :origin => _from, :within => 2, :order=>'distance asc', :conditions => {:is_geocoded => true, :is_active => true})
  end
  
  def geocoded?
    return self.is_geocoded
  end
  
  def self.yp_scrape
    scraped = YpScraper.new
    my_kitas = scraped.get_yp_data
    if my_kitas != false
      my_kitas.each do |mk|
        kita = Kita.new
        kita.name = mk[:name]
        kita.contact = mk[:contact]
        kita.street = mk[:street]
        kita.zip = mk[:zip]
        kita.city = mk[:city]
        kita.phone = mk[:phone]
        kita.url = mk[:url]
        kita.details = mk[:details]
        kita.age_from = mk[:age_from]
        kita.age_to = mk[:age_to]
        kita.is_active = mk[:is_active]
        kita.is_geocoded = false
        kita.is_active = false
        kita.data_origin = "http://yellow.local.ch/de/q/Kinderkrippe, Kinderhort.html#start=0&sort=alphanum&order=asc&categoryidref=1SUzBh8iZOr4Wi80mw-VWg"
        kita.geocode_me("Schweiz")
        kita.save
      end
    else
      puts "******************** ERROR WHILE SCRAPING"
    end
  end
  
  def self.kita_scrape
    scraped = KitaScraper.new
    my_kitas = scraped.get_kita_data
    my_kitas.each do |mk|
      kita = Kita.new
      kita.name = mk[:name]
      kita.contact = mk[:contact]
      kita.street = mk[:street]
      kita.zip = mk[:zip]
      kita.city = mk[:city]
      kita.phone = mk[:phone]
      kita.url = mk[:url]
      kita.details = mk[:details]
      kita.age_from = mk[:age_from]
      kita.age_to = mk[:age_to]
      kita.is_active = mk[:is_active]
      kita.is_geocoded = false
      kita.is_active = false
      kita.data_origin = "http://www.kinderkrippen-online.ch/"
      kita.geocode_me("Schweiz")
      kita.save
    end
  end
  
  def geocode_me(_country)
    if self.street == "-" || self.street.empty?
      self.is_active = false
      self.is_geocoded = false
    else
      geo = GeoKit::Geocoders::GoogleGeocoder.geocode("#{self.street}, #{self.city}, #{_country}")
      if geo.success == true
        self.is_active = true
        self.is_geocoded = true
        self.lat, self.lng, self.geocoded_address, self.country_code = geo.lat, geo.lng, geo.to_geocodeable_s, geo.country_code
      else
        self.is_active = false
        self.is_geocoded = false
        self.errors.add(:geocoded_address, "Could not geocode address")
      end
    end
  end
  
  def set_no_kita_vote
    self.no_kita_votes += 1
    if self.no_kita_votes >= 3
      self.is_active = false
    end
    self.save
  end
  
  # returns map marker that can be used with the ym4r_gm plugin
  def map_marker
=begin
    kita_icon = GIcon.new(:image => "/images/red-dot.png",
       :shadow => "/images/shadow.png",
       :shadow_size => GSize.new(49,32),
       :icon_anchor => GPoint.new(16,32))
=end
    GMarker.new([self.lat, self.lng], :title => "#{self.name}", :info_window => "
    <p> <b>#{self.name}</b><br />#{self.street}<br />#{self.country_code}-#{self.zip} #{self.city} </p>
    <p><a href='/kitas/#{self.id}'>Mehr Details...</a></p>
      ")
  end
  
  # used by will_paginate-gem to define how many objects should be shown on a page
  # see: http://mislav.uniqpath.com/static/will_paginate/doc/
  def self.per_page
    5
  end
  
end
