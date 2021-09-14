require 'simplecov'
require 'ffaker'

SimpleCov.start do
  add_filter(%r{/spec/})
  add_filter('vendor')
  minimum_coverage 100
end

require 'new_super_codebreaker_2021'
require_relative 'new_super_codebreaker_2021/support/helper'

Dir["#{Dir.pwd}/spec/support/**/*.rb"].sort.each { |f| require f }

RSpec.configure do |config|
  config.include Helper, :include_helpers
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
