require 'simplecov'
require 'ffaker'

SimpleCov.start do
  minimum_coverage 95
  add_filter 'spec'
  add_filter 'vendor'
end

require_relative '../lib/loader'
