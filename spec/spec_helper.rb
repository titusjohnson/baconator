require 'vcr'

Dir[File.dirname(__FILE__) + '/../lib/*'].each {|file| require file }

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock # or :fakeweb

  # Instead of wrapping every spec with a VCR call, let's automatically
  # wrap every HTTP call and use a casset based on the wiki page's name
  config.around_http_request do |request|
    VCR.use_cassette(request.uri.split('/wiki/').last, record: :new_episodes, &request)
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
