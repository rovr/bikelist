require 'test_helper'
require "minitest/autorun"

describe Fetchers do
  it "Fetches list of bikes by type" do
    VCR.use_cassette('bikes/giant') do
      link = "http://www.giant-bicycles.com/en-us/bike-catalogue/series/off-road/8/"
      Fetchers::Giant.new(link).fetch_bikes
    end
  end

  it "fetches bike data" do
    VCR.use_cassette('bikes/propel_advanced') do
      FactoryGirl.reload
      bike = FactoryGirl.create :bike
      Fetchers::GiantBikeInfo.new(bike).fetch_and_update_bike_data
      byebug
    end
  end
end
