require "icalendar"
require "icalendar/google/version"
require "icalendar/google/helpers"
require "icalendar/google/parsers"

module Icalendar
  class Calendar
    extend  Google::Parsers
    include Google::Helpers
  end

  module Google
    def self.cid(google_id)
      Base64.encode64(google_id).gsub(%r{\n|=+\Z}, "")
    end

    def self.webcal_url(google_id)
      "webcal://calendar.google.com/calendar/ical/#{CGI.escape(google_id)}/public/basic.ics"
    end

    def self.google_url(google_id)
      "https://calendar.google.com/calendar/r?cid=#{cid(google_id)}"
    end
  end
end
