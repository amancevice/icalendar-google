require "rake/clean"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new :spec

task :default => :spec

namespace :gem do
  require "bundler/gem_tasks"

  gem = "pkg/icalendar-google-#{Icalendar::Google::VERSION}.gem"

  desc "Push #{gem} to rubygems.org"
  task :push => :build do
    sh "gem", "push", gem
  end
end
