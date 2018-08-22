# frozen_string_literal: true

# TODO: access_token In the future maybe issued by Oauth2
module StockShaker
  module Config
    class JDCentralConfig
      attr_accessor :app_key, :app_secret, :access_token

      def initialize
        @app_key = nil
        @app_secret = nil
        @access_token = nil
      end
    end
  end
end
