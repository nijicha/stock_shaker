# frozen_string_literal: true

require 'digest'
require 'openssl'

module StockShaker
  module Client
    class ShopeeOP
      attr_reader :common_params, :server_url, :rest_url

      def initialize(server_url, shop_id)
        @common_params = {
          shopid: shop_id,
          partner_id: StockShaker.config.shopee_config.partner_id,
          timestamp: DateTime.now.to_time.to_i
        }
        @server_url = server_url
        @rest_url = nil
        validates!
      end

      def execute(request, api_params)
        request_params = api_params.merge(@common_params).to_json
        @rest_url = "#{@server_url}#{request.api_name}"

        signature = do_signature(@rest_url, request_params)

        request.add_header_params('content-type', 'json')
        request.add_header_params('Authorization', signature)

        perform(@rest_url, request, request_params)
      end

      def do_authorization_link
        token_base_string = "#{StockShaker.config.shopee_config.secret_key}#{redirect_url}"
        token = Digest::SHA256.hexdigest(token_base_string)

        params = {
          id: StockShaker.config.shopee_config.partner_id,
          token: token,
          redirect: StockShaker.config.shopee_config.redirect_url
        }

        "#{parent::SHOPEE_API_AUTH_URL}?#{params.to_query}"
      end

      def do_signature(rest_url, api_params)
        signature_base_string = "#{rest_url}|#{api_params}"
        OpenSSL::HMAC.hexdigest('SHA256', StockShaker.config.shopee_config.secret_key, signature_base_string)
      end

      def perform(url, request, api_params)
        response = RestClient::Request.execute(
          method: request.http_method,
          payload: api_params,
          url: url,
          timeout: 10,
          headers: request.header_params
        )
        JSON.parse(response)
      end

      def validates!
        raise 'server_url is required' unless @server_url
      end
    end
  end
end