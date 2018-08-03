<p align="center">
  <a href="https://rubygems.org/gems/stock_shaker"><img src="https://github.com/nijicha/stock_shaker/blob/master/media/icon.png?raw=true" height="120" /></a>
  <h3 align="center">Stock Shaker</h3>
  <p align="center">Unofficial Rubygems for Thailand eCommerce Marketplace</p>

  <p align="center">
    <a href="https://badge.fury.io/rb/stock_shaker"><img src="https://badge.fury.io/rb/stock_shaker@2x.png" alt="Gem Version" height="18"></a>
    <a href="https://travis-ci.org/nijicha/stock_shaker"><img src="https://travis-ci.org/nijicha/stock_shaker.svg?branch=master" alt="Gem Version" height="18"></a>
  </p>
  <p align="center">
    <a href="https://forthebadge.com"><img src="https://forthebadge.com/images/badges/built-with-love.svg" alt="For The Badge Built with Love"></a>
    <a href="https://forthebadge.com"><img src="https://forthebadge.com/images/badges/made-with-ruby.svg" alt="For The Badge Made with Ruby"></a>
    <a href="https://shields.io/"><img src="https://github.com/nijicha/stock_shaker/blob/master/media/badge/made_with-shield_io-green.svg" alt="Shield.io Made with shield.io" /></a>
  </p>
  <p align="center">
    <a href="https://www.lazada.co.th/"><img src="https://github.com/nijicha/stock_shaker/blob/master/media/badge/market_place_support/love-lazada-sky-blue.svg" alt="Love Lazada" /></a>
    <a href="https://www.shopee.co.th/"><img src="https://github.com/nijicha/stock_shaker/blob/master/media/badge/market_place_support/love-shopee-orange.svg" alt="Love Shopee" /></a>
  </p>
</p>

A gems used to kick off API of eCommerce in Thailand. This gems inspired from [Official Lazada Open Platform Gems](https://rubygems.org/gems/lazop_api_client/versions/1.2.5)

## Installation

**StockShaker**'s installation is Easy! Add this line to your application's `Gemfile`

```ruby
gem 'stock_shaker', '~> 0.2.9'
```

If you'd rather install **StockShaker** with ruby-versions below than `2.4`.

You need to add `openssl` as dependencies in `Gemfile`

```ruby
# Gemfile
 
gem 'stock_shaker', '~> 0.2.9'
gem 'openssl'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install stock_shaker

## Usage

### Configurable

- Create `stock_shaker_config.rb` in `config/initializer`
- Please ensure you already configured it.

```ruby
# config/initializer/stock_shaker_config.rb
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
### Do Authorization Link <img src="https://github.com/nijicha/stock_shaker/blob/master/media/badge/stock_shaker-new-orange.svg" alt="NEW API" />

<b>* You should be define the `StockShaker.configure` before typing this command.</b>

#### Lazada
```ruby
StockShaker::Client::LazadaOP.do_authorization_link

=> "https://auth.lazada.com/oauth/authorize?client_id=YOUR_LAZADA_APP_KEY&force_auth=true&redirect_uri=YOUR_LAZADA_REDIRECT_URL&response_type=code"
```

#### Shopee
```ruby
StockShaker::Client::ShopeeOP.do_authorization_link

=> "https://partner.shopeemobile.com/api/v1/shop/auth_partner?id=YOUR_SHOPEE_PARTNER_ID&redirect=YOUR_SHOPEE_REDIRECT_URL&token=AUTHORIZATION_TOKEN"
```

### Lazada Open Platform

- <img src="https://github.com/nijicha/stock_shaker/blob/master/media/badge/lazada/lazada_api-system--api-yellow.svg" alt="SystemAPI" />

    - <a href="https://open.lazada.com/doc/api.htm?spm=a2o9m.11193487.0.0.3ac413feha8qCs#/api?cid=11&path=/auth/token/create">
        <img src="https://github.com/nijicha/stock_shaker/blob/master/media/badge/lazada/generate_access_token.svg" alt="Generate Access Token" />
      </a>

    ```ruby
    server_url = StockShaker::Client::LAZADA_API_GATEWAY_URL_TH
    lazada_client = StockShaker::Client::LazadaOP.new(server_url)
    lazada_request = StockShaker::Request.new('/auth/token/create', :post)
    lazada_request_params = { code: 'YOUR_AUTHORIZATION_CODE' }
    lazada_request_params.each { |key, value| request.add_lazada_api_params(key.to_s, value.to_s) }
    response = lazada_client.execute(lazada_request)
    response.success?
    response.body
    ```
    
    - <a href="https://open.lazada.com/doc/api.htm?spm=a2o9m.11193487.0.0.3ac413feha8qCs#/api?cid=11&path=/auth/token/refresh">
        <img src="https://github.com/nijicha/stock_shaker/blob/master/media/badge/lazada/refresh_access_token.svg" alt="Refresh Access Token" />
      </a>

    ```ruby
    server_url = StockShaker::Client::LAZADA_API_GATEWAY_URL_TH
    lazada_client = StockShaker::Client::LazadaOP.new(server_url)
    lazada_request = StockShaker::Request.new('/auth/token/refresh', :post)
    lazada_request_params = { refresh_token: 'YOUR_REFRESH_TOKEN' }
    lazada_request_params.each { |key, value| request.add_lazada_api_params(key.to_s, value.to_s) }
    response = lazada_client.execute(lazada_request)
    response.success?
    response.body
    ```

- <img src="https://github.com/nijicha/stock_shaker/blob/master/media/badge/lazada/lazada_api-order--api-yellow.svg" alt="Lazada OrderAPI" />

    - <a href="https://open.lazada.com/doc/api.htm?spm=a2o9m.11193535.0.0.62a738e4DBO8DQ#/api?cid=8&path=/orders/get">
        <img src="https://github.com/nijicha/stock_shaker/blob/master/media/badge/lazada/get_orders-get-green.svg" alt="OrderAPI GetOrders" />
      </a>
    
    ```ruby
    server_url = StockShaker::Client::LAZADA_API_GATEWAY_URL_TH
    access_token = ENV['YOUR_ACCESS_TOKEN']
    lazada_client = StockShaker::Client::LazadaOP.new(server_url)
    lazada_request = StockShaker::Request.new('/orders/get', :get)

    # Get orders since last two days by update_after
    days_backwards = 2 # Get backwards 2 days
    update_after = StockShaker::Utility.datetime_to_iso8601(DateTime.now.beginning_of_day - days_backwards.days)
  
    lazada_request_params = { 
      created_before: '2018-02-10T16:00:00+07:00',
      created_after: '2017-02-10T09:00:00+07:00',
      status: 'shipped',
      update_before: '2018-02-10T16:00:00+07:00',
      sort_direction: 'DESC',
      offset: 0,
      limit: 100,
      update_after: update_after,
      sort_by: 'updated_at'
    }

    lazada_request_params.each { |key, value| request.add_lazada_api_params(key.to_s, value.to_s) }
    response = lazada_client.execute(lazada_request, access_token)
    puts response.success?
    puts response.body
    ```

### Shopee Open Platform

- <img src="https://github.com/nijicha/stock_shaker/blob/master/media/badge/shopee/shopee_api-order--api-yellow.svg" alt="Shopee OrderAPI" />

    - <a href="https://open.shopee.com/documents?module=4&type=1&id=399">
        <img src="https://github.com/nijicha/stock_shaker/blob/master/media/badge/shopee/get_orders_list-post-green.svg" alt="OrderAPI GetOrdersList" />
      </a>
    
    ```ruby
    server_url = StockShaker::Client::SHOPEE_API_GATEWAY_URL_TH
    shop_id = ENV['YOUR_SHOP_ID']
    
    update_time_from = StockShaker::Utility.datetime_to_timestamp(DateTime.now.beginning_of_day - 2.days)
    update_time_to = StockShaker::Utility.datetime_to_timestamp(DateTime.now)
    
    client = StockShaker::Client::ShopeeOP.new(server_url, shop_id)
    request = StockShaker::Request.new('/orders/basics', :post)
    
    request.add_shopee_api_params({
      update_time_from: update_time_from,
      update_time_to: update_time_to,
      pagination_entries_per_page: 100,
      pagination_offset: 0
    })
    
    response = client.execute(request)
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
