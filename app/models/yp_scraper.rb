require 'rubygems'
require 'mechanize'
require 'iconv'

class YpScraper

  attr_accessor :pages
  attr_accessor :agent
  attr_accessor :yp_data

  def initialize
    self.agent = WWW::Mechanize.new
    self.agent.user_agent = "Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-US; rv:1.8.1.13) Gecko/20080311 Firefox/2.0.0.13"
    self.yp_data = []
    self.pages = []
    (0..95).each_with_index do |my_page,ind|
      url = "http://yellow.local.ch/de/q/?ext=1&name=&company=Kinderkrippe%2C+Kinderhort&street=&city=&area=&phone=&start=#{ind.to_s}"
      self.yp_data << get_yp_content(self.agent.get(url))
    end
  end
  
  def get_yp_data
    self.yp_data.flatten!
    if self.yp_data.empty? == false
      return self.yp_data
    else
      return false
    end
  end
  
  private

  def get_yp_content(_page)
    cont = []
    _page.search(".//div[@id = 'results']").css("div.entrybox").each do |my_div|
      name = my_div.css('a.fn').inner_text
      contact = ""
      street = my_div.css('span.street-address').inner_text
      zip = my_div.css('span.postal-code').inner_text
      city = my_div.css('span.locality').inner_text
      phone = my_div.css('a.phonenr').inner_text
      url = ""
      details = ""
      age_from = "" 
      age_to = ""
      cont << { :name => name, :contact => contact, :street => street, :zip => zip, :city => city, :phone => phone, :url => url, :details => details, :age_from => age_from, :age_to => age_to }
    end
    return cont
  end
  
end
