require "cgi"
require "net/http"

module Icalendar
  module Google
    module Parsers
      def from_google_id(id)
        cid = CGI.escape(id)
        url = "https://calendar.google.com/calendar/ical/#{cid}/public/basic.ics"
        from_url(url)
      end

      def from_url(url)
        cid = url[%r{https://calendar.google.com/calendar/ical/(.*?)/public/basic.ics}, 1]
        uri = URI.parse(url)
        ssl = uri.scheme == "https"
        req = Net::HTTP::Get.new(uri.request_uri)
        res = Net::HTTP.start(uri.host, uri.port, use_ssl: ssl) { |http| http.request(req) }
        enc = res['content-type'][%r{charset=(.*)}i, 1]
        bod = enc.nil? ? res.body : res.body.force_encoding(enc)
        Calendar.parse(bod).each do |calendar|
          calendar.ical_url  = url
          calendar.google_id = CGI.unescape(cid)
        end
      end
    end
  end
end
