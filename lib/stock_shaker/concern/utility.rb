# frozen_string_literal: true

require 'cgi'

module StockShaker
  module Utility
    def to_query_params(object)
      base_string = ''

      object.each do |key, value|
        base_string += '&' if base_string.present?
        base_string += "#{key}=#{value}"
      end

      base_string
    end
  end
end
