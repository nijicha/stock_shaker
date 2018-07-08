# frozen_string_literal: true

module StockShaker
  class Request
    attr_writer :timestamp
    attr_reader :api_name, :http_method, :timestamp,
                :api_params, :header_params, :file_params

    def initialize(api_name = nil, http_method = 'POST')
      @api_name = api_name
      @http_method = http_method
      @api_params = {}
      @header_params = {}
      @file_params = {}
      @timestamp = (Time.now.to_f * 1000).to_i
    end

    def add_api_params(key, value)
      raise 'api param key is not String' unless key.is_a? String
      raise 'api param value is not String' unless value.is_a? String
      @api_params[key] = value
    end

    # Currently unused
    def add_header_params(key, value)
      raise 'header param key is not String' unless key.is_a? String
      raise 'header param value is not String' unless value.is_a? String
      @header_params[key] = value
    end

    # Currently unused
    # file_path must be String
    def add_file_params(key, file_path)
      raise 'param key is not String' unless key.is_a? String
      raise 'param file_path is not String' unless file_path.is_a? String
      @file_params[key] = file_path
    end

    def api_name_nil?
      @api_name.nil?
    end
  end
end