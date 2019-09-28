RSpec.describe Icalendar::GoogleCalendar do

  let(:ics) do
    <<~EOS
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
  end

  let(:event)       { Icalendar::Event.new }
  let(:event_id)    { "abcdefghijklmnopqrstuvwxyz@google.com" }
  let(:event_url)   { "https://calendar.google.com/calendar/event?eid=YWJjZGVmZ2hpamtsbW5vcHFyc3R1dnd4eXogYWJjZGVmZ2hpamtsbW5vcHFyc3R1dnd4eXpAZw" }
  let(:google_id)   { "abcdefghijklmnopqrstuvwxyz@group.calendar.google.com" }
  let(:google_url)  { "https://calendar.google.com/calendar/r?cid=YWJjZGVmZ2hpamtsbW5vcHFyc3R1dnd4eXpAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ" }
  let(:ical_url)    { "https://calendar.google.com/calendar/ical/abcdefghijklmnopqrstuvwxyz%40group.calendar.google.com/public/basic.ics" }
  let(:webcal_url)  { "webcal://calendar.google.com/calendar/ical/abcdefghijklmnopqrstuvwxyz%40group.calendar.google.com/public/basic.ics" }

  let(:los_angeles) { TZInfo::Timezone.get("America/Los_Angeles") }
  let(:saturday)    { Date.new(2018, 4, 28) }
  let(:sunday)      { Date.new(2018, 4, 29) }
  let(:monday)      { Date.new(2018, 4, 30) }

  subject { Icalendar::GoogleCalendar.parse(ics).first }

  before { allow(Net::HTTP).to receive(:get).and_return(ics) }
  before { subject.google_id = google_id }
  before { subject.ical_url = ical_url }
  before { event.uid = event_id }

  describe "::from_ical_url" do

    subject { Icalendar::GoogleCalendar.from_ical_url(ical_url) }

    it "stores the ical URL" do
      expect(subject.ical_url).to eq ical_url
    end

    it "stores the Google ID" do
      expect(subject.google_id).to eq google_id
    end
  end

  describe "::from_google_id" do

    subject { Icalendar::GoogleCalendar.from_google_id(google_id) }

    it "stores the ical URL" do
      expect(subject.ical_url).to eq ical_url
    end

    it "stores the Google ID" do
      expect(subject.google_id).to eq google_id
    end
  end

  describe "#cid" do
    it "returns the base64-encoded cid with trailing =s removed" do
      expect(subject.cid).to eq "YWJjZGVmZ2hpamtsbW5vcHFyc3R1dnd4eXpAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ"
    end
  end

  describe "#eid" do
    it "returns the base64-encoded eid with trailing =s removed" do
      expect(subject.eid event).to eq "YWJjZGVmZ2hpamtsbW5vcHFyc3R1dnd4eXogYWJjZGVmZ2hpamtsbW5vcHFyc3R1dnd4eXpAZw"
    end
  end

  describe "#event_url" do
    it "returns the URL to the Google Calendar event" do
      expect(subject.event_url event).to eq event_url
    end
  end

  describe "#events_on" do
    it "returns the first event" do
      expect(subject.events_on saturday).to eq subject.events.slice(0, 1)
    end

    it "returns the second event" do
      expect(subject.events_on sunday).to eq subject.events.slice(1, 1)
    end

    it "returns the no events" do
      expect(subject.events_on monday).to eq []
    end
  end

  describe "#google_url" do
    it "returns the Google Calendar URL" do
      expect(subject.google_url).to eq google_url
    end
  end

  describe "#tz" do
    it "returns the timezone" do
      expect(subject.tz).to eq los_angeles
    end
  end

  describe "#webcal_url" do
    it "returns the iCal URL" do
      expect(subject.webcal_url).to eq webcal_url
    end
  end
end
