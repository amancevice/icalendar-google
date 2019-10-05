# Google iCalendar

[![Build Status](https://travis-ci.com/amancevice/icalendar-google.svg?branch=master)](https://travis-ci.com/amancevice/icalendar-google)
[![Gem Version](https://badge.fury.io/rb/icalendar-google.svg)](https://badge.fury.io/rb/icalendar-google)
[![Test Coverage](https://api.codeclimate.com/v1/badges/9262efaca53e186d1801/test_coverage)](https://codeclimate.com/github/amancevice/icalendar-google/test_coverage)
[![Maintainability](https://api.codeclimate.com/v1/badges/9262efaca53e186d1801/maintainability)](https://codeclimate.com/github/amancevice/icalendar-google/maintainability)

Google Calendar extension for iCalendar

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'icalendar-google'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install icalendar-google

## Usage

```ruby
require "icalendar/google"

google_id  = "ht3jlfaac5lfd6263ulfh4tql8@group.calendar.google.com"
public_url = "https://calendar.google.com/calendar/ical/#{CGI.escape google_id}/public/basic.ics"

gcal = Icalendar::Calendar.from_google_id(google_id).first
# or
gcal = Icalendar::Calendar.from_url(public_url).first

gcal.google_id
# => "ht3jlfaac5lfd6263ulfh4tql8@group.calendar.google.com"

gcal.webcal_url
# => "webcal://calendar.google.com/calendar/ical/ht3jlfaac5lfd6263ulfh4tql8%40group.calendar.google.com/public/basic.ics"

gcal.event_url(gcal.events.last)
# => "https://calendar.google.com/calendar/event?eid=bW9vbnBoYXNlKzE1MTY4MzI0MDAwMDAgaHQzamxmYWFjNWxmZDYyNjN1bGZoNHRxbDhAZw"
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/amancevice/icalendar-google.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
