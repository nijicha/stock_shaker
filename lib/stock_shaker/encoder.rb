# frozen_string_literal: true

require 'openssl'
require 'cgi'

module StockShaker
  class Encoder

    def self.do_signature_base_string(common_params, api_params, api_name)
      params = api_params.nil? ? common_params : common_params.merge(api_params)
      sort_arrays = params.sort_by { |k, v| k.to_s }

      sign_base_string = ''
      sign_base_string += api_name
      sort_arrays.each do |k, v|
        sign_base_string += k.to_s
        sign_base_string += v.to_s
      end

      sign_base_string

      query_string = parameters.merge(basic_params).to_query
      signature =
      request_url = api_url + '?' + query_string + '&Signature=' + signature
      puts request_url
      JSON.parse(reliable_open(request_url).read)
    end

    # Use HMAC-SHA256 for encoded
    # word 'sign' is a 'signature'
    # Lazada : https://open.lazada.com/doc/doc.htm?spm=a2o9m.11193531.0.0.40ed6bbemuDwkW#?nodeId=10451&docId=108069
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
  end
end