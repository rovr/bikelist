module Fetchers
  class Trek
    attr_reader :year

    def initialize year = Date.today.year
      @year = year
    end

    def fetch_bikes
      byebug
    end

    def bike_info
      bike_links.each do |name, link|
        agent.get(bike_info_url(link))
      end
    end

    def bike_links
      @bike_links ||= year_list.links.map {|l| {l.text => l.href.gsub(/\#/, '')[1..-2]} if l.href.try :match, /\/bikes\//}
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

    def agent
      @agent ||= Mechanize.new
    end
  end
end
