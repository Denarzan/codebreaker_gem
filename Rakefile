require 'bundler/gem_tasks'
require 'rubocop/rake_task'

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
  # Ignored
end
