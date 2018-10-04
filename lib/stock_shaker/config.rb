# frozen_string_literal: true

require_relative 'config/lazada_config'
require_relative 'config/shopee_config'

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
    attr_accessor :lazada_config, :shopee_config

    def initialize
      @lazada_config = LazadaConfig.new
      @shopee_config = ShopeeConfig.new
    end
  end
end
