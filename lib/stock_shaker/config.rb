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
    attr_accessor :lazada_app_key, :lazada_app_secret, :lazada_redirect_url,
                  :shopee_partner_id, :shopee_secret_key, :shopee_redirect_url

    def initialize
      @lazada_app_key = nil
      @lazada_app_secret = nil
      @lazada_redirect_url = nil
      @shopee_partner_id = nil
      @shopee_secret_key = nil
      @shopee_secret_key = nil
    end
  end
end