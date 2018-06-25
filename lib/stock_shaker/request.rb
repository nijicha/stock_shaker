# frozen_string_literal: true

module StockShaker
  class Request
    attr_reader :api_name, :http_method, :api_params,
                :http_params, :file_params

    def initialize(api_name = nil, http_method = 'POST')
      @api_name = api_name
      @http_method = http_method
      @api_params = {}
      @http_params = {}
      @file_params = {}
    end

    def add_api_params(key, value)
      raise 'api param key is not String' unless key.is_a? String
      @api_params[key] = value
    end

    def add_http_params(key, value)
      raise 'http param key is not String' unless key.is_a? String
      @http_params[key] = value
    end

    # file_path must be String
    def add_file_params(key, file_path)
      raise 'param key is not String' unless key.is_a? String
      raise 'param file_path is not String' unless file_path.is_a? String
      @file_params[key] = file_path
    end
  end
end