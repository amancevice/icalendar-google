
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "icalendar/google/version"

Gem::Specification.new do |spec|
  spec.name          = "icalendar-google"
  spec.version       = Icalendar::Google::VERSION
  spec.authors       = ["Alexander Mancevice"]
  spec.email         = ["alexander.mancevice@gmail.com"]

  spec.summary       = %q{GoogleCalendar extension for iCalendar gem}
  spec.description   = %q{Parse GoogleCalenders into iCalendar objects from ID or public iCal URL}
  spec.homepage      = "https://github.com/amancevice/icalendar-google"
  spec.license       = "MIT"
  spec.require_paths = ["lib"]
  spec.files         = Dir["README*", "LICENSE*", "lib/**/*"]

  spec.required_ruby_version = Gem::Requirement.new(">= 3.0")

  spec.add_dependency "base64",    "~> 0.2"
  spec.add_dependency "icalendar", "~> 2.5"
  spec.add_dependency "tzinfo",    "~> 2.0"
end
