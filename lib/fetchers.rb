module Fetchers

  class << self
    def fetch_bikes
      Fetchers::Trek.new.fetch_bikes
    end

    def fetch_giant
      Fetchers::Giant.new(link).fetch_bikes
    end
  end

  class BikeFetcher
    def agent
      @agent ||= Mechanize.new
    end

    def bike_type_id
      @bike_type_id ||= Type.find_or_create_by(name: bike_type_name).id
    end
  end

  class DetailFetcher
    attr_reader :url, :bike

    def initialize bike
      @bike = bike
    end

    def fetch_and_update_bike_data
      bike.update_attributes(data: bike_data) if bike_data.many?
    end

    def bike_data
      { price: price,
        image_urls: image_urls,
        description: description,
        specifications: specs}
    end

    def price
      nil
    end

    def image_urls
      nil
    end

    def description
      nil
    end

    def specs
      nil
    end

    def url
      bike.full_url
    end

    def bike_page
      @bike_page ||= agent.get(url)
    end

    def agent
      @agent ||= Mechanize.new
    end
  end


end
