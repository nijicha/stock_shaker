# frozen_string_literal: true

require 'rest-client'
require 'json'
require 'stock_shaker/encoder'
require 'stock_shaker/request'

module StockShaker
  class Client
    attr_reader :server_url, :app_key, :app_secret, :sign_method

    def initialize(server_url, app_key, app_secret)
      @server_url = server_url
      @app_key = app_key
      @app_secret = app_secret
      @sign_method = 'sha256'
    end

    def execute(request, access_token = nil)

      sys_params = {
        app_key: @app_key,
        timestamp: request.timestamp || (Time.now.to_f * 1000).to_i,
        sign_method: 'sha256',
        access_token: access_token
      }

      sys_params[:sign] = sign_api_request(sys_params, request.api_params, request.api_name)

      rpc_url = get_rest_url(@server_url, request.api_name)
      full_url = get_full_url(rpc_url, sys_params)

      obj = nil
      begin
        obj = if request.file_params.size.positive? || request.http_method == 'POST'
                perform_post(full_url, request.api_params, request.file_params, request.header_params)
              else
                perform_get(full_url, request.api_params, request.header_params)
              end
      rescue StandardError => e
        raise "#{full_url}, HTTP_ERROR, #{e.message}"
      end

      Response.new(obj)
    end

    def perform_get(url, api_params, header_params)

      param_str = ''
      if api_params != nil
        api_params.each do |k, v|
          param_str += "&#{k}=#{CGI.escape(v)}"
        end
      end
      puts url
      puts param_str
      puts header_params
      JSON.parse(RestClient.get(url + param_str + header_params))
    end

    def perform_post(url, api_params, file_params, header_params)

      all_params = api_params
      if file_params != nil
        file_params.each do |k, v|
          all_params[k] = File.open(v, 'rb')
        end
      end
      JSON.parse(RestClient.post(url, all_params))
    end

    def sign_api_request(sys_params, api_params, api_name)
      sort_arrays = if api_params != nil
                      sys_params.merge(api_params).sort_by { |k, v| k.to_s }
                    else
                      sys_params.sort_by { |k, v| k.to_s }
                    end

      sign_str = ''
      sign_str += api_name
      sort_arrays.each do |k, v|
        sign_str += k.to_s
        sign_str += v.to_s
      end

      OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), @app_secret, sign_str).upcase
    end

    def get_rest_url(url, api_name)
      length = url.length
      rest_url = url[(length - 1)] == '/' ? url.chomp!('/') : url
      rest_url + api_name
    end

    def get_full_url(url, params)
      param_str = ''
      params.each do |k, v|
        param_str += '&' unless param_str.empty?
        param_str += "#{k}=#{CGI.escape(v.to_s)}"
      end

      # Return full_url
      "#{url}?#{param_str}"
    end
  end
end