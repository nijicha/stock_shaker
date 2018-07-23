module StockShaker
  class Config
    # TODO: Add validation
    class ShopeeConfig
      attr_accessor :partner_id, :secret_key, :redirect_url

      def initialize
        @partner_id = nil
        @secret_key = nil
        @redirect_url = nil
      end
    end
  end
end