# frozen_string_literal: true

require 'stock_shaker/lazada_open_platform/client'
require 'stock_shaker/lazada_open_platform/request'
require 'stock_shaker/lazada_open_platform/response'

module StockShaker
  module LazadaOpenPlatform
    API_AUTHORIZATION_URL = 'https://auth.lazada.com/oauth/authorize'.freeze
    API_AUTHENTICATION_URL = 'https://auth.lazada.com/rest'.freeze
    API_GATEWAY_URL_SG = 'https://api.lazada.sg/rest'.freeze
    API_GATEWAY_URL_MY = 'https://api.lazada.com.my/rest'.freeze
    API_GATEWAY_URL_VN = 'https://api.lazada.vn/rest'.freeze
    API_GATEWAY_URL_TH = 'https://api.lazada.co.th/rest'.freeze
    API_GATEWAY_URL_PH = 'https://api.lazada.com.ph/rest'.freeze
    API_GATEWAY_URL_ID = 'https://api.lazada.co.id/rest'.freeze

    def self.generate_authorization_link

      authorization_url = API_AUTHORIZATION_URL
      app_key = StockShaker.config.lazada_app_key
      redirect_url = StockShaker.config.lazada_redirect_url

      params = {
        response_type: 'code',
        force_auth: true,
        redirect_uri: redirect_url,
        client_id: app_key
      }

      "#{authorization_url}?#{params.to_query}"
    end
  end
end