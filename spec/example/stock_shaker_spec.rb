# frozen_string_literal: true

require 'stock_shaker'

RSpec.describe StockShaker, '#hi' do

  it 'test_english_hello' do
    expect StockShaker.hi('english').eql?('hello world')
  end

  it 'test_any_hello' do
    expect StockShaker.hi('ruby').eql?('hello world')
  end

  it 'test_spanish_hello' do
    expect StockShaker.hi('spanish').eql?('hola mundo')
  end
end
