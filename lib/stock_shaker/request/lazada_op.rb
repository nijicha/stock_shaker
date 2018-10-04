# frozen_string_literal: true

module StockShaker
  module Request
    class LazadaOP
      attr_reader :api_name, :http_method, :api_params, :header_params

      def initialize(api_name = nil, http_method = :post)
        @api_name = api_name
        @http_method = http_method
        @api_params = {}
        @header_params = {}

        validate!
      end

      def add_api_params(key, value)
        raise 'api_params key is not String' unless key.is_a? String
        raise 'api_params value is not String' unless value.is_a? String
        @api_params[key] = value
      end

      def add_header_params(key, value)
        raise 'header param key is not String' unless key.is_a? String
        raise 'header param value is not String' unless value.is_a? String
        @header_params[key] = value
      end

      def validate!
        raise 'api_name is required' if @api_name.blank?
        raise 'http_method accepted only :get or :post' unless %i[get post].include?(@http_method)
      end
    end
  end
end
