require "icalendar"
require "net/http"
require "tzinfo"

class GoogleCalendar < Icalendar::Calendar
  attr_accessor :google_id, :ical_url

  def cid
    Base64.encode64(google_id).gsub(%r{\n|=+\Z}, "")
  end

  def eid(event)
    seed = "#{event.uid.split(%r{@}).first} #{google_id[0..27]}"
    Base64.encode64(seed).gsub(%r{\n|=+\Z}, "")
  end

  def event_url(event)
    "https://calendar.google.com/calendar/event?eid=#{eid event}"
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
    TZInfo::Timezone.get self.x_wr_timezone.first
  end

  def webcal_url
    ical_url.sub(%r{\Ahttps?://}, "webcal://")
  end

  class << self
    def from_ical_url(url)
      cid = url[%r{https://calendar.google.com/calendar/ical/(.*?)/public/basic.ics}, 1]
      uri = URI.parse(url)
      res = Net::HTTP.get(uri)
      cal = self.parse(res).first
      cal&.ical_url  = url
      cal&.google_id = CGI.unescape(cid)
      cal
    end

    def from_google_id(id)
      url = "https://calendar.google.com/calendar/ical/#{CGI::escape id}/public/basic.ics"
      cal = from_ical_url(url)
      cal&.google_id = id
      cal
    end
  end
end
