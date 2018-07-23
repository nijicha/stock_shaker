# frozen_string_literal: true

require 'openssl'

module StockShaker
  module Client
    class LazadaOP
      attr_reader :common_params, :server_url, :rest_url

      def initialize(server_url, access_token = nil)
        @common_params = {
          app_key: StockShaker.config.lazada_config.app_key,
          timestamp: (Time.now.to_f * 1000).to_i,
          sign_method: 'sha256',
          access_token: access_token
        }
        @server_url = server_url
        @rest_url = nil

        validates!
      end

      def execute(request)
        @common_params[:sign] = do_signature(request.api_params, request.api_name)
        @rest_url = do_rest_url(@server_url, request.api_name, @common_params)
        perform(@rest_url, request)
      rescue StandardError => err
        raise "#{@rest_url}, HTTP_ERROR, #{err.message}"
      end

      def do_signature(api_params, api_name)
        params = api_params.nil? ? common_params : common_params.merge(api_params)
        sort_arrays = params.sort_by { |k, v| k.to_s }

        # See signature pattern : https://open.lazada.com/doc/doc.htm?spm=a2o9m.11193531.0.0.40ed6bbemuDwkW#?nodeId=10451&docId=108069
        signature_base_string = api_name.to_s
        sort_arrays.each { |k, v| signature_base_string += "#{k}#{v}" }

        sign_digest = OpenSSL::Digest.new('sha256')
        OpenSSL::HMAC.hexdigest(sign_digest, StockShaker.config.lazada_config.app_secret_key, signature_base_string).upcase
      end

      # REVIEW: Regarding to Lazada Open Platform Official rubygem
      # @common_params didn't sort!!!!
      # Can't use to_query method for @common_params
      # Parse hash to query string by manually
      def do_rest_url(server_url, api_name, common_params)
        raise 'Signature should not be blank. Please generate signature by LazadaOP#do_signature.' if common_params[:sign].blank?
        length = server_url.length
        rest_url = server_url[(length - 1)] == '/' ? server_url.chomp!('/') : server_url

        common_params_string = ''
        common_params.each do |key, value|
          common_params_string += '&' unless common_params_string.blank?
          common_params_string += "#{key}=#{value}"
        end
        "#{rest_url + api_name}?#{common_params_string}"
      end

      # REVIEW: Regarding to Regarding to Lazada Open Platform Official rubygem
      # header_params is unused.
      def perform(url, request)
        query_params = request.api_params.blank? ? '' : request.api_params.to_query
        response = RestClient::Request.execute(
          method: request.http_method,
          url: "#{url}&#{query_params}",
          timeout: 10,
          headers: request.header_params
        )
        JSON.parse(response)
      end

      def validates!
        raise 'server_url is required' unless @server_url
      end

      def self.do_authorization_link
        params = {
          response_type: 'code',
          force_auth: true,
          client_id: StockShaker.config.lazada_config.app_key,
          redirect_uri: StockShaker.config.lazada_config.redirect_url
        }

        "#{StockShaker::Client::LAZADA_API_AUTH_URL}?#{params.to_query}"
      end
    end
  end
end
