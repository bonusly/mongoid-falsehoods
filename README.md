# Mongoid::Falsehoods

Querying fields in Mongo for those with `null` values will often look like this:

`db.users.find({ deleted_at: null })`

This is inefficient, even if you've indexed `users.deleted_at` because Mongo
has to look for both documents that have a `null` value in the `deleted_at`
field and documents that do not have a `deleted_at` field set at all. If you
look at the explain results, you'll see `"stage": "FETCH"` instead of
`"stage": "IDXSCAN"`, which is really what we want.

Mongoid does not support storing `false` instead of `null` for `DateTime` fields.

This gem convinces it to allow doing so.

I'd encourage you to do some baseline explain queries, look at the
`executionTimeMillis` before the change. Then, add the Gem, migrate existing
data, and see the difference. This is Mongo's estimation of how long it'll take to run the quey.

Here's an example:

```ruby
# before
User.where(deleted_at: nil).explain['executionStats']['executionTimeMillis'] # 4197
# after
User.where(deleted_at: false).explain['executionStats']['executionTimeMillis'] #=> 3055
```

So by switching from `null` to `false`, we shaved off about a second from this query. The improvement will vary based on the number of documents. That's with around 790,000.

Hopefully Mongo will address [this Jira ticket](https://jira.mongodb.org/browse/SERVER-18861) at some point and make this gem unnecessary.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mongoid-falsehoods'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install mongoid-falsehoods

## Usage

Turn code from this:

```ruby
field :deleted_at, type: DateTime

index({ deleted_at: 1 }, background: true)

def self.not_deleted
  where(deleted_at: nil)
end

def active?
  deleted_at.nil?
end
```

to

```ruby
field :deleted_at, type: DateTime, default: false

index({ deleted_at: 1 }, background: true)

def self.not_deleted
  where(deleted_at: false)
end

def active?
  !deleted_at
end
```

You'll also have to migrate existing data:

```ruby
User.where(deleted_at: null).update_all(deleted_at: false)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bonusly/mongoid-falsehoods. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/bonusly/mongoid-falsehoods/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Mongo::Falsehoods project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/bonusly/mongoid-falsehoods/blob/master/CODE_OF_CONDUCT.md).

## About Bonusly

![Bonusly Logo](https://bonusly-files.s3.amazonaws.com/bonusly-logo.png?test=2)

Bonusly is the fun and easy way to engage all of your employees and improve retention and productivity at every level of your organization.

Check out [our product](https://bonus.ly) or [our engineering blog](https://engineering.bonus.ly).
