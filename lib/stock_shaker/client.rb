# frozen_string_literal: true

require 'rest-client'
require 'json'

module StockShaker
  class Client
    attr_reader :server_url, :app_key, :app_secret

    def initialize(server_url, app_key, app_secret)
      @server_url = server_url
      @app_key = app_key
      @app_secret = app_secret
    end

    def execute(request, access_token)
      puts request
      puts access_token
    end

    # Read more :​https://github.com/rest-client/rest-client
    def perform_rest_client(url, api_params, method)

      raise 'api_params should not be nil' unless api_params

      # Return apis response
      response = case method
                 when 'GET'
                   RestClient.get(url, api_params)
                 when 'POST'
                   RestClient.post(url, api_params)
                 else
                   raise `Invalid rest-client method please use GET or POST`
                 end
      JSON.parse(response)
    end
  end
end