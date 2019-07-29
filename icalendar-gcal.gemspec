
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "icalendar-gcal"
  spec.version       = "0.2.1"
  spec.authors       = ["Alexander Mancevice"]
  spec.email         = ["alexander.mancevice@gmail.com"]

  spec.summary       = %q{GoogleCalendar extension for iCalendar gem}
  spec.description   = %q{Parse GoogleCalenders into iCalendar objects from ID or public iCal URL}
  spec.homepage      = "https://github.com/amancevice/icalendar-gcal"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  
  spec.required_ruby_version = Gem::Requirement.new(">= 2.2.0")

  spec.add_runtime_dependency "icalendar", "~> 2.4"
  spec.add_runtime_dependency "tzinfo",    "~> 1.2"

  spec.add_development_dependency "bundler",   "~> 2.0"
  spec.add_development_dependency "pry",       "~> 0.11"
  spec.add_development_dependency "rake",      "~> 10.0"
  spec.add_development_dependency "rspec",     "~> 3.0"
  spec.add_development_dependency "simplecov", "~> 0.16"
end
