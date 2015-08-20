module Fetchers
  class BicyclingReviews
    attr_reader :name, :bike

    def initialize bike
      @bike = bike
      @name = @bike.name
    end

    def get_reviews
      bike.update_attributes(bicycling_review_path: review_path) if review_path
    end

    private

    def review_path
      search_page.links.detect {|a| a.text.match /#{name}/}.try(:href)
    end

    def search_page
      @search_page ||= agent.get "http://gearfinder.bicycling.com/gearfinderSearch?gsearch=#{name}"
    end

    def agent
      @agent ||= Mechanize.new
    end
  end
end
