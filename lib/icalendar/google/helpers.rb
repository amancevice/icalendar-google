require "base64"

require "tzinfo"

module Icalendar
  module Google
    module Helpers
      attr_accessor :google_id, :ical_url

      def cid
        Base64.encode64(@google_id.to_s).gsub(%r{\n|=+\Z}, "")
      end

      def eid(event)
        seed = "#{event.uid.split(%r{@}).first} #{@google_id&.slice(0, 28)}"
        Base64.encode64(seed).gsub(%r{\n|=+\Z}, "")
      end

      def event_url(event)
        "https://calendar.google.com/calendar/event?eid=#{eid(event)}"
      end

      def events_on(date)
        events.select do |event|
          start = tz.utc_to_local event.dtstart.to_datetime
          stop  = tz.utc_to_local event.dtend.to_datetime
          start.to_date <= date && date <= stop.to_date
        end
      end

      def google_url
        "https://calendar.google.com/calendar/r?cid=#{cid}"
      end

      def tz
        TZInfo::Timezone.get(x_wr_timezone.first.to_s)
      end

      def webcal_url
        ical_url&.sub(%r{\Ahttps?://}, "webcal://")
      end
    end
  end
end
