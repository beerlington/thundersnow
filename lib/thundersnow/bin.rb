module Thundersnow
  class Bin
    def self.run(args)
      @args = args

      location = args.reject {|a| a =~ /^--/ }[0]

      @weather = Weather.new(@args)

      return puts "Could not locate weather for #{location}" unless @weather.valid?

      if show_forecast?
        show :forecast
      else
        show :current
      end
    end

  private

    def self.show(name)
      puts "\e[32m#{@weather.send(name)}\e[0m"
    end

    def self.show_forecast?
      @args.detect {|a| a == '--forecast' }
    end

  end
end
