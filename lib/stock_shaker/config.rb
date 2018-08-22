# frozen_string_literal: true

require 'stock_shaker/config/lazada_config'
require 'stock_shaker/config/shopee_config'
require 'stock_shaker/config/jd_central_config'

module StockShaker
  class << self
    def configure
      yield config
    end

    def config
      @config ||= Config.new
    end
  end

  # TODO: Add validation
  class Config
    attr_accessor :lazada_config, :shopee_config, :jd_central_config

    def initialize
      @lazada_config = LazadaConfig.new
      @shopee_config = ShopeeConfig.new
      @jd_central_config = JDCentralConfig.new
    end
  end
end
