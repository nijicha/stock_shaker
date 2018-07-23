# frozen_string_literal: true

module StockShaker
  module Client
    # LAZADA
    LAZADA_API_AUTH_URL = 'https://auth.lazada.com/oauth/authorize'.freeze
    LAZADA_API_AUTHENTICATION_URL = 'https://auth.lazada.com/rest'.freeze
    LAZADA_API_GATEWAY_URL_SG = 'https://api.lazada.sg/rest'.freeze
    LAZADA_API_GATEWAY_URL_MY = 'https://api.lazada.com.my/rest'.freeze
    LAZADA_API_GATEWAY_URL_VN = 'https://api.lazada.vn/rest'.freeze
    LAZADA_API_GATEWAY_URL_TH = 'https://api.lazada.co.th/rest'.freeze
    LAZADA_API_GATEWAY_URL_PH = 'https://api.lazada.com.ph/rest'.freeze
    LAZADA_API_GATEWAY_URL_ID = 'https://api.lazada.co.id/rest'.freeze

    # SHOPEE
    SHOPEE_API_AUTH_URL = 'https://partner.shopeemobile.com/api/v1/shop/auth_partner'.freeze
    SHOPEE_API_CANCEL_AUTH_URL = 'https://partner.shopeemobile.com/api/v1/shop/cancel_auth_partner'.freeze
    SHOPEE_API_GATEWAY_URL_TH = 'https://partner.shopeemobile.com/api/v1'.freeze
  end
end