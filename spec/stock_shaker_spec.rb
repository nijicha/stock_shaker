require 'stock_shaker'

RSpec.describe StockShaker do
  it 'has a version number' do
    expect(StockShaker::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(true).to eq(true)
  end
end
