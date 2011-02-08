$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'thundersnow'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  
end

ZIP = "05401"

XML = '<?xml version="1.0"?>
<xml_api_reply version="1"><weather module_id="0" tab_id="0" mobile_row="0" mobile_zipped="1" row="0" section="0" >
<forecast_information><city data="Burlington, VT"/><postal_code data="05401"/><latitude_e6 data=""/><longitude_e6 data=""/><forecast_date data="2011-02-07"/>
<current_date_time data="2011-02-08 03:19:38 +0000"/><unit_system data="US"/></forecast_information><current_conditions>
<condition data="Snow Showers"/><temp_f data="34"/><temp_c data="1"/><humidity data="Humidity: 87%"/><icon data="/ig/images/weather/snow.gif"/>
<wind_condition data="Wind: S at 6 mph"/></current_conditions><forecast_conditions><day_of_week data="Mon"/><low data="20"/><high data="35"/>
<icon data="/ig/images/weather/snow.gif"/><condition data="Snow"/></forecast_conditions><forecast_conditions><day_of_week data="Tue"/><low data="4"/>
<high data="22"/><icon data="/ig/images/weather/snow.gif"/><condition data="Snow"/></forecast_conditions><forecast_conditions><day_of_week data="Wed"/>
<low data="5"/><high data="22"/><icon data="/ig/images/weather/snow.gif"/><condition data="Snow Showers"/></forecast_conditions><forecast_conditions>
<day_of_week data="Thu"/><low data="5"/><high data="18"/><icon data="/ig/images/weather/partly_cloudy.gif"/><condition data="Partly Cloudy"/>
</forecast_conditions></weather></xml_api_reply>'
