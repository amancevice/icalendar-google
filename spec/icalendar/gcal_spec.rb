RSpec.describe Icalendar::GoogleCalendar do
  describe "#cid" do
    context "given a valid Google ID" do
      it "returns the base64-encoded cid with trailing =s removed" do
        cal = Icalendar::GoogleCalendar.new
        cal.google_id = "abcdefghijklmnopqrstuvwxyz@group.calendar.google.com"
        expect(cal.cid).to eq "YWJjZGVmZ2hpamtsbW5vcHFyc3R1dnd4eXpAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ"
      end
    end
  end

  describe "#eid" do
    context "given a valid event" do
      it "returns the base64-encoded eid with trailing =s removed" do
        cal = Icalendar::GoogleCalendar.new
        cal.google_id = "abcdefghijklmnopqrstuvwxyz@group.calendar.google.com"
        evt = Icalendar::Event.new
        evt.uid = "abcdefghijklmnopqrstuvwxyz@google.com"
        eid = cal.eid(evt)
        expect(eid).to eq "YWJjZGVmZ2hpamtsbW5vcHFyc3R1dnd4eXogYWJjZGVmZ2hpamtsbW5vcHFyc3R1dnd4eXpAZw"
      end
    end
  end

  describe "#event_url" do
    context "given a valid event" do
      it "returns the URL to the Google Calendar event" do
        cal = Icalendar::GoogleCalendar.new
        cal.google_id = "abcdefghijklmnopqrstuvwxyz@group.calendar.google.com"
        evt = Icalendar::Event.new
        evt.uid = "abcdefghijklmnopqrstuvwxyz@google.com"
        url = cal.event_url(evt)
        expect(url).to eq "https://calendar.google.com/calendar/event?eid=YWJjZGVmZ2hpamtsbW5vcHFyc3R1dnd4eXogYWJjZGVmZ2hpamtsbW5vcHFyc3R1dnd4eXpAZw"
      end
    end
  end

  describe "#events_on" do
    context "given a date" do
      it "returns only the events on that specific date" do
        ical = <<~EOS
          BEGIN:VCALENDAR
          PRODID:-//Google Inc//Google Calendar 70.9054//EN
          VERSION:2.0
          CALSCALE:GREGORIAN
          METHOD:PUBLISH
          X-WR-CALNAME:Calendar Name
          X-WR-TIMEZONE:America/Los_Angeles
          X-WR-CALDESC:Calendar Description.
          BEGIN:VEVENT
          DTSTART:20180428T190000Z
          DTEND:20180428T210000Z
          END:VEVENT
          BEGIN:VEVENT
          DTSTART:20180429T190000Z
          DTEND:20180429T210000Z
          END:VEVENT
          END:VCALENDAR
        EOS
        allow(Net::HTTP).to receive(:get).and_return(ical)
        cal = Icalendar::GoogleCalendar.from_ical_url "https://calendar.google.com/calendar/ical/abcdefghijklmnopqrstuvwxyz%40group.calendar.google.com/public/basic.ics"
        events = cal.events_on Date.new(2018, 4, 28)
        expect(events).to eq cal.events[0..0]
        events = cal.events_on Date.new(2018, 4, 29)
        expect(events).to eq cal.events[1..1]
        events = cal.events_on Date.new(2018, 4, 30)
        expect(events).to eq []
      end
    end
  end

  describe "#google_url" do
    context "given a valid calendar" do
      it "returns the Google Calendar URL" do
        cal = Icalendar::GoogleCalendar.new
        cal.google_id = "abcdefghijklmnopqrstuvwxyz@group.calendar.google.com"
        expect(cal.google_url).to eq "https://calendar.google.com/calendar/r?cid=YWJjZGVmZ2hpamtsbW5vcHFyc3R1dnd4eXpAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ"
      end
    end
  end

  describe "#tz" do
    context "given a valid calendar" do
      it "returns the timezone" do
        cal = Icalendar::GoogleCalendar.new
        cal.x_wr_timezone = "America/Los_Angeles"
        expect(cal.tz).to eq TZInfo::Timezone.get("America/Los_Angeles")
      end
    end
  end

  describe "#webcal_url" do
    context "given a valid calendar" do
      it "returns the iCal URL" do
        cal = Icalendar::GoogleCalendar.new
        cal.ical_url = "https://calendar.google.com/calendar/ical/abcdefghijklmnopqrstuvwxyz%40group.calendar.google.com/public/basic.ics"
        expect(cal.webcal_url).to eq "webcal://calendar.google.com/calendar/ical/abcdefghijklmnopqrstuvwxyz%40group.calendar.google.com/public/basic.ics"
      end
    end
  end

  describe ".from_ical_url" do
    context "given a valid iCal URL" do
      it "returns a new GoogleCalendar" do
        ical = <<~EOS
          BEGIN:VCALENDAR
          PRODID:-//Google Inc//Google Calendar 70.9054//EN
          VERSION:2.0
          CALSCALE:GREGORIAN
          METHOD:PUBLISH
          X-WR-CALNAME:Calendar Name
          X-WR-TIMEZONE:America/Los_Angeles
          X-WR-CALDESC:Calendar Description.
          END:VCALENDAR
        EOS
        allow(Net::HTTP).to receive(:get).and_return(ical)
        cal = Icalendar::GoogleCalendar.from_ical_url "https://calendar.google.com/calendar/ical/abcdefghijklmnopqrstuvwxyz%40group.calendar.google.com/public/basic.ics"
        expect(cal.ical_url).to eq("https://calendar.google.com/calendar/ical/abcdefghijklmnopqrstuvwxyz%40group.calendar.google.com/public/basic.ics")
        expect(cal.google_id).to eq("abcdefghijklmnopqrstuvwxyz@group.calendar.google.com")
      end
    end
  end

  describe ".from_google_id" do
    context "given a valid Google Calendar ID" do
      it "returns a new GoogleCalendar" do
        ical = <<~EOS
          BEGIN:VCALENDAR
          PRODID:-//Google Inc//Google Calendar 70.9054//EN
          VERSION:2.0
          CALSCALE:GREGORIAN
          METHOD:PUBLISH
          X-WR-CALNAME:Calendar Name
          X-WR-TIMEZONE:America/Los_Angeles
          X-WR-CALDESC:Calendar Description.
          END:VCALENDAR
        EOS
        allow(Net::HTTP).to receive(:get).and_return(ical)
        cal = Icalendar::GoogleCalendar.from_google_id "abcdefghijklmnopqrstuvwxyz@group.calendar.google.com"
        expect(cal.ical_url).to eq("https://calendar.google.com/calendar/ical/abcdefghijklmnopqrstuvwxyz%40group.calendar.google.com/public/basic.ics")
        expect(cal.google_id).to eq("abcdefghijklmnopqrstuvwxyz@group.calendar.google.com")
      end
    end
  end
end
