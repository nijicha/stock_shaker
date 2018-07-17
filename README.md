# StockShaker

[![Gem Version](https://badge.fury.io/rb/stock_shaker.svg)](https://badge.fury.io/rb/stock_shaker)
[![Build Status](https://travis-ci.org/nijicha/stock_shaker.svg?branch=master)](https://travis-ci.org/nijicha/stock_shaker)

A gems used to kick off API for eCommerce in Thailand. This gems inspired from [Official Lazada Open Platform Gems](https://rubygems.org/gems/lazop_api_client/versions/1.2.5)

## Installation

**StockShaker**'s installation is Easy! Add this line to your application's `Gemfile`

```ruby
gem 'stock_shaker', '~> 0.2.0'
```

If you'd rather install **StockShaker** with ruby-versions below than `2.4`.

You need to add `openssl` as dependencies in `Gemfile`

```ruby
# Gemfile
 
gem 'stock_shaker', '~> 0.2.0'
gem 'openssl'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install stock_shaker

## Usage

# TODO Write WIKI for this
- Create callback for retrieve callback from Lazada Open Platform
1. `rails generate controller LazadaOpenPlatformController`
2. Add `lazada_callback method`
3. Add routes.rb for lazada_callback
4. ....

- SystemAPI::Generate Access Token
```ruby
url = LazadaOpenPlatform::API_AUTHORIZATION_URL
app_key = 'YOUR_APP_KEY'
app_secret = 'YOUR_APP_SECRET'

client = LazadaOpenPlatform::Client.new(url, app_key, app_secret)
request = LazadaOpenPlatform::Request.new('/auth/token/create')
request.add_api_params("code", 'AUTHORIZATION_CODE')
request.add_api_params("uuid", "38284839234")
response = client.execute(request)
puts response.success?
puts response.body # retrieve access_token and refresh_token
```

- OrderAPI::GetOrders

```ruby
url = LazadaOpenPlatform::API_GATEWAY_URL_TH
app_key = 'YOUR_APP_KEY'
app_secret = 'YOUR_APP_SECRET'
access_token = 'YOUR_ACCESS_TOKEN'

# Get orders since last two days by update_after
update_after = Utility.datetime_to_iso8601_format(DateTime.now.beginning_of_day - 2.days)

client = LazadaOpenPlatform::Client.new(url, app_key, app_secret)
request = LazadaOpenPlatform::Request.new('/orders/get','GET')
request.add_api_params("created_before", "2018-02-10T16:00:00+08:00")
request.add_api_params("created_after", "2017-02-10T09:00:00+08:00")
request.add_api_params("status", "shipped")
request.add_api_params("update_before", "2018-02-10T16:00:00+08:00")
request.add_api_params("sort_direction", "DESC")
request.add_api_params("offset", "0")
request.add_api_params("limit", "10")
request.add_api_params("update_after", update_after)
request.add_api_params("sort_by", "updated_at")
response = client.execute(request, access_token)
puts response.success?
puts response.body
```
- See more: [Lazada Open Platform Documentation](https://open.lazada.com/doc/api.htm?spm=a2o9m.11193535.0.0.62a738e4DBO8DQ#/api?cid=8&path=/order/document/get)

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
- [ ] Logger
- [ ] Sentry.io Integration

### Lazada
See more: [Lazada Open Platform Documentation](https://open.lazada.com/doc/api.htm?spm=a2o9m.11193535.0.0.62a738e4DBO8DQ#/api?cid=8&path=/order/document/get)

- [ ] Integrate with API reference
- [ ] Order API
    - [x] GetOrders
    - [x] GetMultipleOrderItems
- [ ] Product API
    - [x] GetProducts
    - [x] UpdatePriceQuantity
- [ ] Finance API
- [ ] Logistics API
- [ ] Seller API
- [x] System API
    - [x] Generate Access Token
    - [x] Refresh Access Token
- [ ] DataMoat API

### Shopee
See more: [Shopee Open Platform Documentation](https://open.shopee.com/documents)
- [ ] Integrate with API reference

### JD Central

- [ ] Integrate with API reference

## Development
1. `git clone https://github.com/nijicha/stock_shaker.git`
2. `bundle install`

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/nijicha/stock_shaker](https://github.com/nijicha/stock_shaker).

This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
