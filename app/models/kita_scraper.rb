require 'rubygems'
require 'mechanize'
require 'iconv'

class KitaScraper

  attr_accessor :page
  attr_accessor :agent
  attr_accessor :locations
  attr_accessor :content_div

  def initialize
    @url = "http://www.kinderkrippen-online.ch/Kinderbetreuung/"
    @agent = WWW::Mechanize.new
    @page = @agent.get(@url)
    cantons = ["Aargau", "Appenzell_AI", "Appenzell_AR", "Bern", "Basel-Land", "Basel-Stadt", "Fribourg", "Genf", "Glarus", "Graubuenden", "Jura", "Luzern", "Neuenburg", "Nidwalden", "Obwalden", "Schaffhausen", "Schwyz", "Solothurn", "St-Gallen", "Tessin", "Thurgau", "Uri", "Waadt", "Wallis", "Zug", "Zuerich"]
    cities = ["Aarau", "Baden", "Biel", "Brugg", "Olten", "Stadt-Bern", "Stadt-Luzern", "Stadt-Solothurn", "Stadt-St-Gallen", "Stadt-Zuerich", "Thun", "Uster", "Wabern", "Wettingen", "Winterthur", "Stadt-Zug"]
    @locations = cities + cantons
  end
  
  def get_kita_data
    kita_data = []
    my_kita_links = get_kita_links(get_loc_links)
    puts "************ FOUND #{my_kita_links.size} KITA CONTENT PAGES!"
    my_kita_links.each do |kita_link|
      kita_data << get_kita_content(kita_link)
    end
    unless kita_data.empty?
      return kita_data
    else
      return false
    end
  end
  
  private
  
  def get_loc_links
    loc_links = []
    @locations.each do |location|
      @page.links.each do |link|
        link.href[/(#{location}.aspx)/] unless link.href.nil?
        # if there's output from the regex above
        unless $1.nil?
          is_new = true
          loc_links.each do |loc_link|
            is_new = false if loc_link.href == link.href
          end
          loc_links << link if is_new
        end
      end
    end
    puts "************ FOUND #{loc_links.size} LOCATION LINK(S) FOR #{@locations.size} LOCATIONS!"
    return loc_links
  end
  
  def get_kita_links(_loc_links)
    kita_links = []
    _loc_links.each do |loc_link|
      loc_page = @agent.click loc_link
      loc_page.links.each do |page_link|
        page_link.href[/(\d+.aspx)/] unless page_link.href.nil?
        # if there's output from the regex above
        unless $1.nil?
          is_new = true
          kita_links.each do |kita_link|
            is_new = false if kita_link.href == page_link.href
          end
          kita_links << page_link if is_new
        end
      end
    end
    return kita_links
  end

  def get_kita_content(_kita_link)
    kita_page = @agent.click _kita_link
    cont = []
    # form#frmStelleGUI > table.txt09 > tbody
    @content_div = kita_page.search(".//table[@class ='txt09']")
    
    @content_div.css('td').each do |td|
      cont << td.inner_text
    end

    # Institution
    name = cont[7].chomp
    # Kontaktperson
    contact = cont[9].chomp
    # Strasse/Postfach
    street = cont[11].chomp.gsub(",","").gsub("-","").gsub(/(,*\s*Postfach\s*\d*)/,"")
    # PLZ
    cont[13][/(\d+)\s.*/]
    zip = $1.chomp.gsub(" ", "") unless $1.nil?
    # Ort 
    cont[13][/\d+\s(.*)/]
    city = $1.chomp.gsub(",","") unless $1.nil?
    # Telefonnummer
    phone = cont[17].chomp.gsub("-", "")
    # Webseite
    url = cont[21].chomp.gsub(" ", "").gsub("-", "")
    # Zusatzinformationen der Einrichtung / Institution
    details = cont[25].chomp.gsub(" ", "").gsub("-", "")
    # Kinder im Alter ab
    age_from = cont[41].chomp.gsub("-", "")
    # Kinder im Alter bis
    age_to = cont[43].chomp.gsub("-", "")
    
    return { :name => name, :contact => contact, :street => street, :zip => zip, :city => city, :phone => phone, :url => url, :details => details, :age_from => age_from, :age_to => age_to }

  end
  
end
