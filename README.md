# RuboCop::PublicFeatureMethods

This cop replaces

- `module.send(:include, another_module)` with `module.include(another_module)`
- `module.send(:prepend, another_module)` with `module.prepend(another_module)`

## Background

`Module#include` and `Module#prepend` are public methods [as of Ruby 2.1.0](https://github.com/ruby/ruby/blob/v2_1_0/NEWS), but there are still a bunch of code like `IssuesController.send(:include, IssuesControllerPatch)` in Redmine plugins. This cop helps you update them.

## Installation

**Gemfile**

```ruby
group :development do
  gem 'rubocop-public_feature_methods', git: 'https://github.com/agileware-jp/rubocop-public_feature_methods.git', require: false
end
```

**.rubocop.yml**

```yaml
inherit_gem:
  rubocop-public_feature_methods: config/default.yml
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

To run tests, run `bundle rspec`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/agileware-jp/rubocop-public_feature_methods.
