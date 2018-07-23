# StockShaker - Unofficial Rubygems for Thailand eCommerce Marketplace

[![Gem Version](https://badge.fury.io/rb/stock_shaker.svg)](https://badge.fury.io/rb/stock_shaker)
[![Build Status](https://travis-ci.org/nijicha/stock_shaker.svg?branch=master)](https://travis-ci.org/nijicha/stock_shaker)

A gems used to kick off API of eCommerce in Thailand. This gems inspired from [Official Lazada Open Platform Gems](https://rubygems.org/gems/lazop_api_client/versions/1.2.5)

## Installation

**StockShaker**'s installation is Easy! Add this line to your application's `Gemfile`

```ruby
gem 'stock_shaker', '~> 0.2.1'
```

If you'd rather install **StockShaker** with ruby-versions below than `2.4`.

You need to add `openssl` as dependencies in `Gemfile`

```ruby
# Gemfile
 
gem 'stock_shaker', '~> 0.2.1'
gem 'openssl'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install stock_shaker

## Usage

### Configurable

```ruby
StockShaker.configure do |config|
  # Lazada Configuration
  config.lazada_config.app_key = ENV['YOUR_LAZADA_APP_KEY']
  config.lazada_config.app_secret_key = ENV['YOUR_LAZADA_APP_SECRET_KEY']
  config.lazada_config.redirect_url = ENV['YOUR_LAZADA_REDIRECT_URL']

  # Shopee Configuration
  config.shopee_config.partner_id = ENV['YOUR_SHOPEE_PARTNER_ID']
  config.shopee_config.secret_key = ENV['YOUR_SHOPEE_SECRET_KEY']
  config.shopee_config.redirect_url = ENV['YOUR_SHOPEE_REDIRECT_URL']
end
```

### Lazada Open Platform

- SystemAPI
    - [Generate `access_token`](https://open.lazada.com/doc/api.htm?spm=a2o9m.11193487.0.0.3ac413feha8qCs#/api?cid=11&path=/auth/token/create)

    ```ruby
    server_url = StockShaker::Client::LAZADA_API_AUTH_URL
    lazada_client = StockShaker::Client::LazadaOP.new(server_url)
    lazada_request = StockShaker::Request.new('/auth/token/create')
    lazada_request.add_api_params('code', 'YOUR_AUTHORIZATION_CODE')
    response = lazada_client.execute(lazada_request)
    response.success?
    response.body # retrieve access_token and refresh_token
    ```

    - [Refresh `access_token`](https://open.lazada.com/doc/api.htm?spm=a2o9m.11193487.0.0.3ac413feha8qCs#/api?cid=11&path=/auth/token/refresh)

    ```ruby
    server_url = StockShaker::Client::LAZADA_API_AUTH_URL
    lazada_client = StockShaker::Client::LazadaOP.new(server_url)
    lazada_request = StockShaker::Request.new('/auth/token/refresh')
    lazada_request.add_api_params('refresh_token', 'YOUR_REFRESH_TOKEN')
    response = lazada_client.execute(lazada_request)
    response.success?
    response.body # retrieve new access_token and refresh_token
    ```

- OrderAPI
    - [GetOrders](https://open.lazada.com/doc/api.htm?spm=a2o9m.11193535.0.0.62a738e4DBO8DQ#/api?cid=8&path=/order/document/get)
    
    ```ruby
    server_url = StockShaker::Client::LAZADA_API_GATEWAY_URL_TH
    access_token = ENV['YOUR_ACCESS_TOKEN']
    lazada_client = StockShaker::Client::LazadaOP.new(server_url, access_token)
    lazada_request = StockShaker::Request.new('/orders/get', :get)

    # Get orders since last two days by update_after
    days_backwards = 2 # Get backwards 2 days
    update_after = StockShaker::Utility.datetime_to_iso8601(DateTime.now.beginning_of_day - days_backwards.days)

    lazada_request.add_api_params('created_before', '2018-02-10T16:00:00+07:00')
    lazada_request.add_api_params('created_after', '2017-02-10T09:00:00+07:00')
    lazada_request.add_api_params('status', 'shipped')
    lazada_request.add_api_params('update_before', '2018-02-10T16:00:00+07:00')
    lazada_request.add_api_params('sort_direction', 'DESC')
    lazada_request.add_api_params('offset', '0')
    lazada_request.add_api_params('limit', '10')
    lazada_request.add_api_params('update_after', update_after)
    lazada_request.add_api_params('sort_by', 'updated_at')
    response = lazada_client.execute(lazada_request)
    puts response.success?
    puts response.body
    ```

## Compatibility
We supported
- Ruby MRI 2.2+
- Rails 5.0+

## Need helps!
- Contributed this gems!
- Write Test!

## TODO

### Core

- [x] Configurable
  - [ ] Validation
- [ ] Generator
- [ ] Write Rspec
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
- OrderAPI
  - [x] GetOrdersList

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
