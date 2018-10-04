# frozen_string_literal: true

module StockShaker
  module Request
    class JDCentralOP
      attr_reader :api_name, :http_method, :api_params, :business_params, :header_params

      def initialize(api_name = nil, http_method = :post)
        @api_name = api_name
        @http_method = http_method
        @api_params = {}
        @business_params = {}
        @header_params = {}

        validate!
      end

      def add_api_params(hash)
        raise 'api_params is not hash' unless hash.is_a? Hash
        @api_params = hash
      end

      def add_business_params(hash)
        raise 'business_params is not hash' unless hash.is_a? Hash
        @business_params = hash
      end

      def add_header_params(key, value)
        raise 'header param key is not String' unless key.is_a? String
        raise 'header param value is not String' unless value.is_a? String
        @header_params[key] = value
      end

      def validate!
        raise 'api_name is required' if @api_name.blank?
        raise 'http_method accepted only :post' unless @http_method.eql?(:post)
      end
    end
  end
end
