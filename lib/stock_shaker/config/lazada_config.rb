module StockShaker
  class Config
    # TODO: Add validation
    class LazadaConfig
      attr_accessor :app_key, :app_secret_key, :redirect_url

      def initialize
        @app_key = nil
        @app_secret_key = nil
        @redirect_url = nil
      end
    end
  end
end