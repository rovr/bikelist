module Fetchers
  class Trek < BikeFetcher
    attr_reader :year

    def initialize year = Date.today.year
      @year = year
    end

    def fetch_bikes
      bike_info
    end

    def bike_info
      @bike_info ||= bike_links[16..-1].first(3).map do |bike|
        TrekBike.new bike.first[0], bike.first[1]
      end
    end

    def bike_links
      @bike_links ||= year_list.links.map {|l| {l.text => l.href.gsub(/\#/, '')[1..-2]} if l.href.try(:match, /\/bikes\//) && l.href.length > 13}.compact
    end

    def year_list
      @year_list ||= agent.get base_url
    end

    def base_url
      "http://www.trekbikes.com/int/en/bikes/#{year}/archive/"
    end

    def bike_info_url bike_url
      "http://www.trekbikes.com/int/en/model/details/?url=#{bike_url}"
    end
  end

  class TrekBike
    attr_reader :name, :body

    def initialize name, path
      @name = name
      @body = body
      @path = path
    end

  end
end
