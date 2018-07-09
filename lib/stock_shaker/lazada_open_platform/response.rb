# frozen_string_literal: true

# response type nil,ISP,ISV,SYSTEM
# nil ：no error
# ISP : API Service Provider Error
# ISV : API Request Client Error
# SYSTEM : Lazop platform Error

module StockShaker
  module LazadaOpenPlatform
    class Response
      attr_reader :type, :code, :message, :body, :request_id

      def initialize(object)
        @type = object['type']
        @code = object['code']
        @message = object['message']
        @body = object
        @request_id = object['request_id']
      end

      def success?
        @code.eql?('0')
      end
    end
  end
end
