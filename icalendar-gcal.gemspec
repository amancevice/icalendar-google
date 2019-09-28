
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "icalendar/gcal/version"

Gem::Specification.new do |spec|
  spec.name          = "icalendar-gcal"
  spec.version       = Icalendar::Google::VERSION
  spec.authors       = ["Alexander Mancevice"]
  spec.email         = ["alexander.mancevice@gmail.com"]

  spec.summary       = %q{GoogleCalendar extension for iCalendar gem}
  spec.description   = %q{Parse GoogleCalenders into iCalendar objects from ID or public iCal URL}
  spec.homepage      = "https://github.com/amancevice/icalendar-gcal"
  spec.license       = "MIT"
  spec.require_paths = ["lib"]
  spec.files         = Dir["README*", "LICENSE*", "lib/**/*"]

  spec.required_ruby_version = Gem::Requirement.new(">= 2.2.0")

  spec.add_runtime_dependency "icalendar",   "~> 2.5"
  spec.add_runtime_dependency "tzinfo",      "~> 2.0"
  spec.add_runtime_dependency "tzinfo-data", "~> 1.2019"

  spec.add_development_dependency "bundler",   "~> 2.0"
  spec.add_development_dependency "pry",       "~> 0.12"
  spec.add_development_dependency "rake",      "~> 12.3"
  spec.add_development_dependency "rspec",     "~> 3.0"
  spec.add_development_dependency "simplecov", "~> 0.16"
end
