require 'test_helper'
require "minitest/autorun"

describe Fetchers do
  it "Fetches list of bikes by type" do
    VCR.use_cassette('bikes/fetch_review') do
      FactoryGirl.reload
      bike = FactoryGirl.create :gt_bike, name: "Propel Advanced SL 0"
      Fetchers::BicyclingReviews.new(bike).get_reviews
      assert_equal bike.reload.bicycling_review_path, "/bikes/road-race/propel-advanced-sl-0"
    end
  end
end
