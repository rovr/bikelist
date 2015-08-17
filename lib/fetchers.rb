module Fetchers

  class << self
    def fetch_bikes
      Fetchers::Trek.new.fetch_bikes
    end

    def fetch_giant
      Fetchers::Giant.new(link).fetch_bikes
    end
  end


end
