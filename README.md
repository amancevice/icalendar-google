# Google iCalendar

![gem](https://img.shields.io/gem/v/icalendar-google?logo=rubygems&logoColor=eee&style=flat-square)
[![rspec](https://github.com/amancevice/icalendar-google/actions/workflows/rspec.yml/badge.svg)](https://github.com/amancevice/icalendar-google/actions/workflows/rspec.yml)
[![coverage](https://qlty.sh/gh/amancevice/projects/icalendar-google/coverage.svg)](https://qlty.sh/gh/amancevice/projects/icalendar-google)
[![maintainability](https://qlty.sh/gh/amancevice/projects/icalendar-google/maintainability.svg)](https://qlty.sh/gh/amancevice/projects/icalendar-google)

Google Calendar extension for iCalendar

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'icalendar-google'
```

And then execute:

```bash
bundle
```

Or install it yourself as:

```bash
gem install icalendar-google
```

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

Bug reports and pull requests are welcome on GitHub at [amancevice/icalendar-google](https://github.com/amancevice/icalendar-google).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
