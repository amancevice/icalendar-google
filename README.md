# Google iCalendar

Google Calendar extension for iCalendar

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gcalendar'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gcalendar

## Usage

```ruby
require "gcalendar"

gcal = GoogleCalendar.from_google_id("abcdefghijklmnopqrstuvwxyz@group.calendar.google.com")
# or
gcal = GoogleCalendar.from_ical_url("https://calendar.google.com/calendar/ical/abcdefghijklmnopqrstuvwxyz%40group.calendar.google.com/public/basic.ics")

gcal.google_id
# => "abcdefghijklmnopqrstuvwxyz@group.calendar.google.com"

gcal.webcal_url
# => "webcal://calendar.google.com/calendar/ical/abcdefghijklmnopqrstuvwxyz%40group.calendar.google.com/public/basic.ics"

gcal.event_url(gcal.events.last)
# => "https://calendar.google.com/calendar/event?eid=YWJjZGVmZ2hpamtsbW5vcHFyc3R1dnd4eXogYWJjZGVmZ2hpamtsbW5vcHFyc3R1dnd4eXpAZw"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/gcalendar.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
