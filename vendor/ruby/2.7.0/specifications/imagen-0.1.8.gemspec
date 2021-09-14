# -*- encoding: utf-8 -*-
# stub: imagen 0.1.8 ruby lib

Gem::Specification.new do |s|
  s.name = "imagen".freeze
  s.version = "0.1.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jan Grodowski".freeze]
  s.bindir = "exe".freeze
  s.date = "2019-03-19"
  s.email = ["jgrodowski@gmail.com".freeze]
  s.homepage = "https://github.com/grodowski/imagen_rb".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.2.25".freeze
  s.summary = "Codebase as structure of locatable classes and methods based on the Ruby AST".freeze

  s.installed_by_version = "3.2.25" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<parser>.freeze, [">= 2.5", "!= 2.5.1.1"])
    s.add_development_dependency(%q<bundler>.freeze, ["~> 2.0"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 12.3"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_development_dependency(%q<rubocop>.freeze, ["~> 0.66.0"])
    s.add_development_dependency(%q<pry>.freeze, [">= 0"])
    s.add_development_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_development_dependency(%q<simplecov-lcov>.freeze, [">= 0"])
    s.add_development_dependency(%q<simplecov-html>.freeze, [">= 0"])
  else
    s.add_dependency(%q<parser>.freeze, [">= 2.5", "!= 2.5.1.1"])
    s.add_dependency(%q<bundler>.freeze, ["~> 2.0"])
    s.add_dependency(%q<rake>.freeze, ["~> 12.3"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 0.66.0"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_dependency(%q<simplecov-lcov>.freeze, [">= 0"])
    s.add_dependency(%q<simplecov-html>.freeze, [">= 0"])
  end
end
