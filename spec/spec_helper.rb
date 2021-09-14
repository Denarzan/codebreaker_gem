require 'simplecov'
require 'ffaker'
require 'new_super_codebreaker_2021'

SimpleCov.start do
  minimum_coverage 95
  add_filter 'spec'
  add_filter 'vendor'
end
