module Fetchers

  class << self
    def fetch_bikes
      Fetchers::Trek.new.fetch_bikes
    end
  end


end
