[![CircleCI](https://circleci.com/gh/nxt-insurance/nxt_heroku_env.svg?style=svg)](https://circleci.com/gh/nxt-insurance/nxt_heroku_env)

# NxtHerokuEnv

This gem checks the `HEROKU_APP_NAME` environment variable that is set by Heroku for any app that runs on Heroku. You can ask the helpers which environment you run in and even draw different routes depending on it. This is useful if your application should behave differently depending on whether it runs in some environment, typically production and staging for example.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nxt_heroku_env'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nxt_heroku_env

## Usage

A typical application setup on heroku might have a *staging* and a *production* environment. You can set `HerokuEnv` up like this (assuming your heroku app pipelines are named something like `myapp-p` and `myapp-s` for production and staging environments respectively).

```ruby
HerokuEnv.configure do |config|
	config.add_env production: /myapp-p/
	config.add_env staging: /myapp-s/
end
```

If you use rails, you might want to add an initializer with this content to your project (`config/initializers/heroku_env.rb`).

Now you can use the DSL methods to ask for the heroku environment your app instance runs in.

```ruby
HerokuEnv.env
# => :staging

HerokuEnv.staging?
# => true

HerokuEnv.production?
# => false
```

There's also a method for each environment that yields a block if the environment matches the one the app runs in. This can be useful e.g. in views when a part of markup should only be rendered when the app runs in a given environment.

```ruby
HerokuEnv.staging do
	puts "Hello world from staging"
end

# => "Hello world from staging"

HerokuEnv.production do
	puts "Hello world from production"
end

# => nil
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

We use the [standard](https://github.com/testdouble/standard) gem to ensure consistent code formatting. Please run `bundle exec standardrb --fix` before commiting to apply the code styles to your changes.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nxt-insurance/nxt_heroku_env.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
