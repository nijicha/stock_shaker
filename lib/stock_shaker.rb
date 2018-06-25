# frozen_string_literal: true

require 'stock_shaker/version'

require 'stock_shaker/request'
require 'stock_shaker/encoder'

module StockShaker
  # module_function Guide: https://github.com/rubocop-hq/ruby-style-guide#module-function
  module_function

  def hi(language = 'english')
    language == 'spanish' ? 'hola mundo' : 'hello world'
  end
end
