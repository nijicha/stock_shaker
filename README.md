# StockShaker

[![Gem Version](https://badge.fury.io/rb/stock_shaker.svg)](https://badge.fury.io/rb/stock_shaker)
[![Build Status](https://travis-ci.org/nijicha/stock_shaker.svg?branch=master)](https://travis-ci.org/nijicha/stock_shaker)

A gems used to kick off API for eCommerce in Thailand. This gems inspired from [Official Lazada Open Platform Gems](https://rubygems.org/gems/lazop_api_client/versions/1.2.5)

## Installation

**StockShaker**'s installation is Easy! Add this line to your application's `Gemfile`

```ruby
gem 'stock_shaker'
```

If you'd rather install **StockShaker** with ruby-versions below than `2.4`.

You need to add `openssl` as dependencies in `Gemfile`

```ruby
gem 'openssl'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install stock_shaker

## Usage

TODO: Write usage instructions here

## Compatibility
We supported
- Ruby MRI 2.2+
- Rails 5.0+

## Need helps!
- Contributed this gems!
- Write Test!

## TODO

### Core

- [ ] Write TDD with Rspec

### Lazada

- [ ] Integrate with API reference
- [ ] Order API
- [ ] Product API
- [ ] Finance API
- [ ] Logistics API
- [ ] Seller API
- [x] System API
- [ ] DataMoat API

### Shopee

- [ ] Integrate with API reference

### JD Central

- [ ] Integrate with API reference

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/stock_shaker. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the StockShaker project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/stock_shaker/blob/master/CODE_OF_CONDUCT.md).
