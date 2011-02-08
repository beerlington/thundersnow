require 'nokogiri'
require 'open-uri'

class Thundersnow
  class << self
    def run(location)
      uri = URI.encode "http://www.google.com/ig/api?weather=#{location}"
      @xml = Nokogiri::XML(open(uri))

      # Invalid locations contain problem_cause xml tag
      if @xml.xpath('//weather/problem_cause').size > 0
        return puts "Could not locate weather for #{location}"
      end

      show :city
      puts "-------------------------"
      show :condition
      show :temperatures
      show :wind
      show :humidity
      puts "-------------------------"
      show :forecast
    end

  private

    def show(name)
      puts send(name)
    end

    def city
      city = read_attr(@xml, '//forecast_information/city')
      "Weather forecast for #{city}"
    end

    def condition
      read_attr(current_conditions, 'condition')
    end

    def temperatures
      "#{temp_f} / #{temp_c}"
    end

    def wind
      read_attr(current_conditions, 'wind_condition')
    end

    def humidity
      read_attr(current_conditions, 'humidity')
    end

    def temp_f
      read_attr(current_conditions, 'temp_f').to_s + 'F'
    end

    def temp_c
      read_attr(current_conditions, 'temp_c').to_s + 'C'
    end

    def current_conditions
      @current_conditions ||= @xml.xpath('//current_conditions')
    end

    def forecast
      @xml.xpath('//forecast_conditions').map do |day|
        "Forecast for #{read_attr(day, 'day_of_week')} \n" +
        "High: #{read_attr(day, 'high')}F / Low: #{read_attr(day, 'low')}F \n" +
        "Conditions: #{read_attr(day, 'condition')} \n" +
        "-------------------------\n"
      end
    end

    def read_attr(root, node)
      root.xpath(node).attribute('data')
    end
  end

end
