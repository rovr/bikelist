require 'test_helper'
require "minitest/autorun"

describe Fetchers do
  it "Fetches list of bikes by type" do
    VCR.use_cassette('bikes/fuji') do
      Fetchers::Fuji.new('2015', 4).fetch_bikes
    end
  end

  it "fetches bike details" do
    VCR.use_cassette('bikes/fuji_details') do
      FactoryGirl.reload
      bike = FactoryGirl.create :bike, url: "http://archive.fujibikes.com/archivebikes.php?prodid=3560&prodname=Absolute 1.1 Disc&modelyear=2015"
      Fetchers::Fuji
      Fetchers::FujiDetails.new(bike).fetch_and_update_bike_data
    end
  end
end
