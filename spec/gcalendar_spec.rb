RSpec.describe GoogleCalendar do
  describe "#cid" do
    context "given a valid Google ID" do
      it "returns the base64-encoded cid with trailing =s removed" do
        cal = GoogleCalendar.new
        cal.google_id = "abcdefghijklmnopqrstuvwxyz@group.calendar.google.com"
        expect(cal.cid).to eq "YWJjZGVmZ2hpamtsbW5vcHFyc3R1dnd4eXpAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ"
      end
    end
  end

  describe "#eid" do
    context "given a valid event" do
      it "returns the base64-encoded eid with trailing =s removed" do
        cal = GoogleCalendar.new
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
        cal = GoogleCalendar.new
        cal.google_id = "abcdefghijklmnopqrstuvwxyz@group.calendar.google.com"
        evt = Icalendar::Event.new
        evt.uid = "abcdefghijklmnopqrstuvwxyz@google.com"
        url = cal.event_url(evt)
        expect(url).to eq "https://calendar.google.com/calendar/event?eid=YWJjZGVmZ2hpamtsbW5vcHFyc3R1dnd4eXogYWJjZGVmZ2hpamtsbW5vcHFyc3R1dnd4eXpAZw"
      end
    end
  end

  describe "#events_on" do
  end

  describe "#google_url" do
    context "given a valid calendar" do
      it "returns the Google Calendar URL" do
        cal = GoogleCalendar.new
        cal.google_id = "abcdefghijklmnopqrstuvwxyz@group.calendar.google.com"
        expect(cal.google_url).to eq "https://calendar.google.com/calendar/r?cid=YWJjZGVmZ2hpamtsbW5vcHFyc3R1dnd4eXpAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ"
      end
    end
  end

  describe "#tz" do
    context "given a valid calendar" do
      it "returns the timezone" do
        cal = GoogleCalendar.new
        cal.x_wr_timezone = "America/Los_Angeles"
        expect(cal.tz).to eq TZInfo::Timezone.get("America/Los_Angeles")
      end
    end
  end

  describe "#webcal_url" do
    context "given a valid calendar" do
      it "returns the iCal URL" do
        cal = GoogleCalendar.new
        cal.ical_url = "https://calendar.google.com/calendar/ical/abcdefghijklmnopqrstuvwxyz%40group.calendar.google.com/public/basic.ics"
        expect(cal.webcal_url).to eq "webcal://calendar.google.com/calendar/ical/abcdefghijklmnopqrstuvwxyz%40group.calendar.google.com/public/basic.ics"
      end
    end
  end

  describe ".from_ical_url" do
  end

  describe ".from_google_id" do
  end
end
