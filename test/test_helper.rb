ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'vcr'

class ActiveSupport::TestCase
  config.include FactoryGirl::Syntax::Methods

  VCR.configure do |c|
    c.cassette_library_dir = 'test/fixtures/vcr'
    c.ignore_localhost = true
    c.hook_into :webmock
    c.allow_http_connections_when_no_cassette = true
    c.default_cassette_options = {allow_playback_repeats: true, match_requests_on: [:query]}
  end

  # Add more helper methods to be used by all tests here...
end
