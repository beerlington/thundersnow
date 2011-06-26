require 'htmlentities'

module Thundersnow
  class Weather

    def initialize(location)
      @xml = get_weather_xml(location)
    end

    def get_weather_xml(location)
      uri = URI.encode "http://www.google.com/ig/api?weather=#{location}"
      Nokogiri::XML(open(uri))
    end

    # Invalid locations contain problem_cause xml tag
    def valid?
      @xml.xpath('//weather/problem_cause').size == 0
    end

    def current
      values = ["Current Conditions for #{city}"]
      values << condition
      values << temperatures
      values << wind
      values << humidity
      values.join("\n")
    end

    def forecast
      values = ["Weather Forecast for #{city}"]

      @xml.xpath('//forecast_conditions').each do |day|
        values << "Forecast for #{day_of_week(day)}"
        values << "High: #{read_attr(day, 'high')+deg_symbol}F / Low: #{read_attr(day, 'low')+deg_symbol}F"
        values << "Conditions: #{read_attr(day, 'condition')}"
        values << "-------------------------"
      end

      values.join("\n")
    end

    def city
      @city ||= read_attr(@xml, '//forecast_information/city')
    end

    def day_of_week(day)
      day_of_week = read_attr(day, 'day_of_week')
      return "Today" if day_of_week == today
      return "Tomorrow" if day_of_week == tomorrow
      day_of_week
    end

    def condition
      read_attr(current_conditions, 'condition')
    end

    def temperatures
      "#{temp_f} #{deg_symbol}F / #{temp_c} #{deg_symbol}C"
    end

    def wind
      read_attr(current_conditions, 'wind_condition')
    end

    def humidity
      read_attr(current_conditions, 'humidity')
    end

    def temp_f
      read_attr(current_conditions, 'temp_f')
    end

    def temp_c
      read_attr(current_conditions, 'temp_c')
    end

    def current_conditions
      @current_conditions ||= @xml.xpath('//current_conditions')
    end

  private

    def read_attr(root, node)
      root.xpath(node).attribute('data').to_s
    end

    def today
      Time.now.strftime('%a')
    end

    def tomorrow
      (Time.now + 86400).strftime('%a')
    end

    def deg_symbol
      HTMLEntities.new.decode("&deg;")
    end

  end
end
