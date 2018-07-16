# frozen_string_literal: true

require 'digest'
require 'active_support/core_ext/object/to_query'

module StockShaker
  module ShopeeOpenPlatform
    class Client
      def self.generate_authorization_link
        authorization_url = parent::API_AUTHORIZATION_URL
        partner_id = StockShaker.config.partner_id
        secret_key = StockShaker.config.secret_key
        redirect_url = StockShaker.config.redirect_url

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
end