# frozen_string_literal: true

require 'digest'
require 'active_support/core_ext/object/to_query'

module StockShaker
  module ShopeeOpenPlatform
    API_AUTHORIZATION_URL = 'https://partner.shopeemobile.com/api/v1/shop/auth_partner'.freeze
    API_AUTHORIZATION_TEST_URL = 'https://partner.uat.shopeemobile.com/api/v1/shop/auth_partner'.freeze

    def self.generate_authorization_link
      authorization_url = API_AUTHORIZATION_URL
      partner_id = StockShaker.config.shopee_partner_id
      secret_key = StockShaker.config.shopee_secret_key
      redirect_url = StockShaker.config.shopee_redirect_url

      # long string by key + redirect_url
      token_base_string = "#{secret_key}#{redirect_url}"
      token = Digest::SHA256.hexdigest(token_base_string)

      params = {
        id: partner_id,
        token: token,
        redirect: redirect_url
      }

      "#{authorization_url}?#{params.to_query}"
    end
  end
end