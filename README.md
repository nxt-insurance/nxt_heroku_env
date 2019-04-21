# NxtHerokuEnvConstrainable

This gem checks the `HEROKU_APP_NAME` environment variable that is set by Heroku for any app that runs on Heroku. You can ask the helpers which environment you run in and even draw different routes depending on it. This is useful if your application should behave differently depending on whether it runs in some environment, typically production and staging for example.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nxt_heroku_env_constrainable'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nxt_heroku_env_constrainable

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/nxt_heroku_env_constrainable.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
