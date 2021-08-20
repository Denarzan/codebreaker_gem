# frozen_string_literal: true

require_relative "lib/new_super_codebreaker_2021/version"

Gem::Specification.new do |spec|
  spec.name          = "new_super_codebreaker_2021"
  spec.version       = NewSuperCodebreaker2021::VERSION
  spec.authors       = ["Nazar Dakhno"]
  spec.email         = ["dakhnonazar@gmail.com"]
  spec.files         = ["lib"]
  spec.license       = "MIT"

  spec.summary       = "New game codebreaker!"
  spec.description   = "Game where you need to guess the secret code"
  spec.homepage      = "https://rubygems.org/gems/new_super_codebreaker_2021"
  spec.required_ruby_version = ">= 2.7.0"
end
