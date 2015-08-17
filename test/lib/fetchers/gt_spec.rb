require 'test_helper'
require "minitest/autorun"

describe Fetchers do
  it "Fetches list of bikes by type" do
    VCR.use_cassette('bikes/gt') do
      link = "http://www.gtbicycles.com/usa_en/2015/bikes/mountain"
      Fetchers::GT.new(link).fetch_bikes
    end
  end

  it "fetches bike data" do
    VCR.use_cassette('bikes/gt_bike') do
      FactoryGirl.reload
      Fetchers::GT
      bike = FactoryGirl.create :gt_bike
      Fetchers::GTBikeInfo.new(bike).fetch_and_update_bike_data
    end
  end
end
