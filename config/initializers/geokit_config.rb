require 'geokit' #requires the Geokit gem

# These defaults are used in Geokit::Mappable.distance_to and in acts_as_mappable
Geokit::default_units = :kilometres
Geokit::default_formula = :sphere

# This is the timeout value in seconds to be used for calls to the geocoder web
# services.  For no timeout at all, comment out the setting.  The timeout unit
# is in seconds. 
Geokit::Geocoders::timeout = 3

# These settings are used if web service calls must be routed through a proxy.
# These setting can be nil if not needed, otherwise, addr and port must be 
# filled in at a minimum.  If the proxy requires authentication, the username
# and password can be provided as well.
Geokit::Geocoders::proxy_addr = nil
Geokit::Geocoders::proxy_port = nil
Geokit::Geocoders::proxy_user = nil
Geokit::Geocoders::proxy_pass = nil

# This is your yahoo application key for the Yahoo Geocoder.
# See http://developer.yahoo.com/faq/index.html#appid
# and http://developer.yahoo.com/maps/rest/V1/geocode.html
Geokit::Geocoders::yahoo = 'REPLACE_WITH_YOUR_YAHOO_KEY'
    
# This is your Google Maps geocoder key. 
GeoKit::Geocoders::GOOGLE= if RAILS_ENV == 'production'
  'ABQIAAAApsmas9eM670dOts-ajBq-xSpGEys4awoij1NcuFsb7S49m3PQRT5Nb-D9JYTx6AlxAjFbzxp3VBCbQ'
  # key is registered to vazqujav@gmail.com for http://kita.joontos.ch (xxx@joontos.ch didn't work)
else
  # key is registered to frankhofmann@gmail.com for http://localhost
  'ABQIAAAACRidJKgZiYKLU2DKvadcVxT2yXp_ZAY8_ufC3CFXhHIE1NvwkxSLeOcZG0M_gxih_bZbUCmALwXzPA'
end
# This is your username and password for geocoder.us.
# To use the free service, the value can be set to nil or false.  For 
# usage tied to an account, the value should be set to username:password.
# See http://geocoder.us
# and http://geocoder.us/user/signup
Geokit::Geocoders::geocoder_us = false 

# This is your authorization key for geocoder.ca.
# To use the free service, the value can be set to nil or false.  For 
# usage tied to an account, set the value to the key obtained from
# Geocoder.ca.
# See http://geocoder.ca
# and http://geocoder.ca/?register=1
Geokit::Geocoders::geocoder_ca = false

# This is the order in which the geocoders are called in a failover scenario
# If you only want to use a single geocoder, put a single symbol in the array.
# Valid symbols are :google, :yahoo, :us, and :ca.
# Be aware that there are Terms of Use restrictions on how you can use the 
# various geocoders.  Make sure you read up on relevant Terms of Use for each
# geocoder you are going to use.
Geokit::Geocoders::provider_order = [:google]
