# frozen_string_literal: true

require 'json'
require 'openssl'
require 'rest-client'

module StockShaker
  module LazadaOpenPlatform
    class Client
      attr_reader :server_url, :app_key, :app_secret, :sign_method

      def initialize(server_url, app_key, app_secret)
        @server_url = server_url
        @app_key = app_key
        @app_secret = app_secret
        @sign_method = 'sha256'

        validate!
      end

      def execute(request, access_token = nil)
        common_params = {
          app_key: @app_key,
          timestamp: request.timestamp || (Time.now.to_f * 1000).to_i,
          sign_method: 'sha256',
          access_token: access_token
        }
        common_params[:sign] = do_signature(common_params, request.api_params, request.api_name)
        rest_url = get_rest_url(@server_url, request.api_name, common_params)

        obj = nil
        begin
          obj = if request.http_method.eql?('POST') || !request.file_params.blank?
                  perform_post(rest_url, request.api_params, request.header_params, request.file_params)
                else
                  perform_get(rest_url, request.api_params, request.header_params)
                end
        rescue StandardError => e
          raise "#{rest_url}, HTTP_ERROR, #{e.message}"
        end

        Response.new(obj)
      end

      def do_signature(common_params, api_params, api_name)
        params = api_params.nil? ? common_params : common_params.merge(api_params)
        sort_arrays = params.sort_by { |k, v| k.to_s }

        # See signature pattern : https://open.lazada.com/doc/doc.htm?spm=a2o9m.11193531.0.0.40ed6bbemuDwkW#?nodeId=10451&docId=108069
        signature_base_string = api_name.to_s
        sort_arrays.each { |k, v| signature_base_string += "#{k}#{v}" }

        sign_digest = OpenSSL::Digest.new(@sign_method)
        OpenSSL::HMAC.hexdigest(sign_digest, @app_secret, signature_base_string).upcase
      end

      def get_rest_url(url, api_name, params)
        length = url.length
        rest_url = url[(length - 1)] == '/' ? url.chomp!('/') : url
        "#{rest_url + api_name}?#{params.to_query}"
      end

      # TODO: implement API with file_params usages
      def perform_get(url, api_params, header_params)
        query_params = api_params.blank? ? '' : api_params.to_query
        response = RestClient::Request.execute(
          method: :get,
          url: "#{url}&#{query_params}",
          timeout: 10,
          headers: header_params
        )
        JSON.parse(response)
      end

      def perform_post(url, api_params, header_params, file_params = nil)
        # all_params = http_method.eql?('POST') && !file_params.blank? ? api_params.merge(get_file_params(file_params)) : api_params

        merge_params = api_params.merge(header_params)
        response = RestClient::Request.execute(
          method: :post,
          url: url,
          timeout: 10,
          headers: merge_params
        )
        JSON.parse(response)
      end

      # def get_file_params(file_params)
      #   return unless file_params
      #   return_params = ''
      #   file_params.each { |k, v| return_params[k] = File.open(v, 'rb') }
      # end

      def validate!
        raise 'app_key is required' unless @app_key
        raise 'app_secret is required' unless @app_secret
      end
    end
  end
end
