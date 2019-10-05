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
        # require "pry"; binding.pry
        body = Net::HTTP.start(uri.host, uri.port, use_ssl: ssl) do |http|
          req = Net::HTTP::Get.new(uri.request_uri)
          res = http.request(req)
          enc = res['content-type'][%r{charset=(.*)}, 1]
          enc.nil? ? res.body : res.body.force_encoding(enc)
        end
        Calendar.parse(body).each do |calendar|
          calendar.ical_url  = url
          calendar.google_id = CGI.unescape(cid)
        end
      end
    end
  end
end
