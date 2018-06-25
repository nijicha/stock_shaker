# frozen_string_literal: true

require 'openssl'
require 'cgi'

module StockShaker
  class Encoder

    # Use HMAC-SHA256 for encoded
    # word 'sign' is a 'signature'
    # Lazada
    # - return value must to .upcase
    # - sign_base_string is sorted by key params and
    #   merged params of (common params | api_params)
    # Shopee
    # - sign_base_string pattern is
    #   concatenating URL, |, raw HTTP body.
    #   Example:
    #   https://partner.shopeemobile.com/api/v1/orders/detail|{"ordersn": "160726152598865", "shopid": 61299, "partner_id": 1, "timestamp": 1470198856}
    def self.do_signature(sign_base_string, app_secret, hash_function = 'sha256')
      sign_digest = OpenSSL::Digest.new(hash_function)

      # return encoded signature string
      OpenSSL::HMAC.hexdigest(sign_digest, app_secret, sign_base_string)
    end

    def self.do_query_string(api_params)
      raise 'StockShaker::Encoder.do_query_string api_params is nil' if api_params.nil?

      # return escaped query string
      query_string = api_params.map { |k, v| "#{k}=#{v}" }.join('&')
      CGI.escape(query_string)
    end
  end
end