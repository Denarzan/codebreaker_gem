lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'new_super_codebreaker_2021/version'



Gem::Specification.new do |spec|
  spec.name          = 'new_super_codebreaker_2021'
  spec.version       = NewSuperCodebreaker2021::VERSION
  spec.authors       = ['Nazar Dakhno']
  spec.email         = ['dakhnonazar@gmail.com']
  spec.files = Dir['README.md', 'lib/**/*']
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib/new_super_codebreaker_2021']
  spec.license       = 'MIT'
  spec.summary       = 'New game codebreaker!'
  spec.description   = 'Game where you need to guess the secret code'
  spec.homepage      = 'https://rubygems.org/gems/new_super_codebreaker_2021'
  spec.required_ruby_version = '>= 2.7.0'
  spec.add_development_dependency 'fasterer', '~> 0.9.0'
  spec.add_development_dependency 'ffaker', '~> 2.19.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.10.0'
  spec.add_development_dependency 'rubocop', '~> 1.7'
  spec.add_development_dependency 'simplecov', '~> 0.21.2'
  spec.add_development_dependency 'terminal-table', '~> 3.0.1'
end
