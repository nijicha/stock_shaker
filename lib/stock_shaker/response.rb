# frozen_string_literal: true

# response type nil,ISP,ISV,SYSTEM
# nil ：no error
# ISP : API Service Provider Error
# ISV : API Request Client Error
# SYSTEM : Lazop platform Error
#
# NOTE: this class currently unused
module StockShaker
  class Response
    attr_reader :type, :code, :message, :body, :request_id

    def initialize(type, code, message, r_id, body)
      @type = type
      @code = code
      @message = message
      @body = body
      @request_id = r_id
    end

    def success?
      @code.eql?('0')
    end
  end
end