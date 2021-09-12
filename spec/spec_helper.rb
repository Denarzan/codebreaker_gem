# frozen_string_literal: true

require 'simplecov'
require 'ffaker'

SimpleCov.start do
  minimum_coverage 95
  add_filter 'spec'
  add_filter 'vendor'
end
