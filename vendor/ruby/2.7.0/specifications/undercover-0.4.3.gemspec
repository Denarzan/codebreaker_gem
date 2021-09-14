# -*- encoding: utf-8 -*-
# stub: undercover 0.4.3 ruby lib

Gem::Specification.new do |s|
  s.name = "undercover".freeze
  s.version = "0.4.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jan Grodowski".freeze]
  s.date = "2021-03-16"
  s.email = ["jgrodowski@gmail.com".freeze]
  s.executables = ["undercover".freeze]
  s.files = ["bin/undercover".freeze]
  s.homepage = "https://github.com/grodowski/undercover".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.5.0".freeze)
  s.rubygems_version = "3.2.25".freeze
  s.summary = "Actionable code coverage - detects untested code blocks in recent changes".freeze

  s.installed_by_version = "3.2.25" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<imagen>.freeze, [">= 0.1.8"])
    s.add_runtime_dependency(%q<rainbow>.freeze, [">= 2.1", "< 4.0"])
    s.add_runtime_dependency(%q<rugged>.freeze, [">= 0.27", "< 1.2"])
    s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_development_dependency(%q<pry>.freeze, [">= 0"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 13.0"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_development_dependency(%q<rubocop>.freeze, ["~> 1.11.0"])
    s.add_development_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_development_dependency(%q<simplecov-html>.freeze, [">= 0"])
    s.add_development_dependency(%q<simplecov-lcov>.freeze, ["~> 0.8"])
    s.add_development_dependency(%q<timecop>.freeze, [">= 0"])
  else
    s.add_dependency(%q<imagen>.freeze, [">= 0.1.8"])
    s.add_dependency(%q<rainbow>.freeze, [">= 2.1", "< 4.0"])
    s.add_dependency(%q<rugged>.freeze, [">= 0.27", "< 1.2"])
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, ["~> 13.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 1.11.0"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_dependency(%q<simplecov-html>.freeze, [">= 0"])
    s.add_dependency(%q<simplecov-lcov>.freeze, ["~> 0.8"])
    s.add_dependency(%q<timecop>.freeze, [">= 0"])
  end
end
