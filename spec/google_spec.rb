RSpec.describe Icalendar::Google do
  let(:google_id) { "abcdefghijklmnopqrstuvwxyz@group.calendar.google.com" }
  let(:google_url) { "https://calendar.google.com/calendar/r?cid=YWJjZGVmZ2hpamtsbW5vcHFyc3R1dnd4eXpAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ" }
  let(:webcal_url) { "webcal://calendar.google.com/calendar/ical/abcdefghijklmnopqrstuvwxyz%40group.calendar.google.com/public/basic.ics" }

  describe "::cid" do
    it "returns the base64-encoded cid with trailing =s removed" do
      expect(described_class.cid(google_id)).to eq "YWJjZGVmZ2hpamtsbW5vcHFyc3R1dnd4eXpAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ"
    end
  end


  describe '::google_url' do
    it "returns the Google subscribe URL" do
      expect(described_class.google_url(google_id)).to eq google_url
    end
  end

  describe '::webcal_url' do
    it "returns the iCal subscribe URL" do
      expect(described_class.webcal_url(google_id)).to eq webcal_url
    end
  end
end
