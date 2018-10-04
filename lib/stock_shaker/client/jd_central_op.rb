# frozen_string_literal: true

require 'digest'
require 'openssl'
require 'rest-client'

module StockShaker
  module Client
    class JDCentralOP
      attr_reader :common_params, :server_url, :app_key, :app_secret, :access_token

      def initialize(server_url, app_key, app_secret, access_token)
        @common_params = {
          timestamp: DateTime.now.strftime('%F %T.%L%z'),
          format: 'json',
          v: '1.0'
        }

        @server_url = server_url
        @app_key = app_key
        @app_secret = app_secret
        @access_token = access_token

        validates!
      end

      def execute(request)
        request_params = @common_params.merge(**request.api_params, **request.business_params)
        request_params[:sign] = do_signature(request_params)

        request.add_header_params('charset', 'utf-8')

        perform(request, request_params.as_json)
      end

      def do_signature(request_params)
        # Sort key by ASCII rule
        sorted_params = request_params.sort_by { |key, _value| key }

        # Create sign_base_string
        sign_base_string = app_secret
        sorted_params.each { |key, value| sign_base_string += "#{key}#{value}" }
        sign_base_string += app_secret

        # Conditional sign by sign_method
        if request_params[:sign_method].include?('hmac')
          digest = OpenSSL::Digest.new('sha256')
          OpenSSL::HMAC.hexdigest(digest, app_secret, sign_base_string).upcase
        else
          Digest::MD5.hexdigest(sign_base_string).upcase
        end
      end

      def perform(request, request_params)
        RestClient::Request.execute(
          method: request.http_method,
          payload: request_params,
          url: @server_url,
          headers: request.header_params
        )
      rescue StandardError => err
        err
      end

      def validates!
        raise 'server_url is required' unless @server_url
        raise 'app_key is required' unless @app_key
        raise 'app_secret is required' unless @app_secret
        raise 'access_token is required' unless @access_token
      end

      # TODO: May be JD Central issued this in the future
      def self.do_authorization_link; end
    end
  end
end
