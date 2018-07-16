# frozen_string_literal: true

require 'stock_shaker/shopee_open_platform/client'

module StockShaker
  module ShopeeOpenPlatform
    API_AUTHORIZATION_URL = 'https://partner.shopeemobile.com/api/v1/shop/auth_partner'.freeze
    API_AUTHORIZATION_TEST_URL = 'https://partner.uat.shopeemobile.com/api/v1/shop/auth_partner'.freeze
  end
end