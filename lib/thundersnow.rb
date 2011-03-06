require 'nokogiri'
require 'open-uri'
require 'htmlentities'

class Thundersnow
  class << self
    def run(args)
      @args = args

      location = args.reject {|a| a =~ /^--/ }[0]

      uri = URI.encode "http://www.google.com/ig/api?weather=#{location}"
      @xml = Nokogiri::XML(open(uri))

      # Invalid locations contain problem_cause xml tag
      if @xml.xpath('//weather/problem_cause').size > 0
        return puts "Could not locate weather for #{location}"
      end

      if show_forecast?
        show :forecast
      else
        show :current
      end
    end

  private

    def show(name)
      puts "\e[32m#{send(name)}\e[0m"
    end

    def show_forecast?
      @args.detect {|a| a == '--forecast' }
    end

    def city
      @city ||= read_attr(@xml, '//forecast_information/city')
    end

    def current
      values = ["Current Conditions for #{city}"]
      values << condition
      values << temperatures
      values << wind
      values << humidity
      values.join("\n")
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
      read_attr(current_conditions, 'temp_f').to_s + deg_symbol + "F"
    end

    def temp_c
      read_attr(current_conditions, 'temp_c').to_s + deg_symbol + 'C'
    end

    def deg_symbol
      HTMLEntities.new.decode("&deg;")
    end

    def current_conditions
      @current_conditions ||= @xml.xpath('//current_conditions')
    end

    def forecast
      values = ["Weather Forecast for #{city}"]

      @xml.xpath('//forecast_conditions').each do |day|
        day_of_week = read_attr(day, 'day_of_week')
        values << "Forecast for #{readable_day(day_of_week)}"
        values << "High: #{read_attr(day, 'high')+deg_symbol}F / Low: #{read_attr(day, 'low')+deg_symbol}F"
        values << "Conditions: #{read_attr(day, 'condition')}"
        values << "-------------------------"
      end

      values.join("\n")
    end

    def readable_day(day_of_week)
      return "Today" if day_of_week == today
      return "Tomorrow" if day_of_week == tomorrow
      day_of_week
    end

    def today
      Time.now.strftime('%a')
    end

    def tomorrow
      (Time.now + 86400).strftime('%a')
    end

    def read_attr(root, node)
      root.xpath(node).attribute('data').to_s
    end
  end

end
