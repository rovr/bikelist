require 'test_helper'
require "minitest/autorun"

describe Fetchers do
  it "works" do
    VCR.use_cassette('bikes/giant') do
      Fetchers.fetch_giant
    end
  end
end
