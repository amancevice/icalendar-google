require "icalendar"
require "icalendar/google/version"
require "icalendar/google/helpers"
require "icalendar/google/parsers"

module Icalendar
  class Calendar
    extend  Google::Parsers
    include Google::Helpers
  end
end
