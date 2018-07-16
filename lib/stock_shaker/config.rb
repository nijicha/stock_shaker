# frozen_string_literal: true

module StockShaker
  class << self
    def configure
      yield config
    end

    def config
      @config ||= Config.new
    end
  end

  class Config
    attr_accessor :partner_id, :secret_key, :redirect_url

    def initialize
      @partner_id = nil
      @secret_key = nil
      @redirect_url = nil
    end
  end
end