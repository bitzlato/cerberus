require 'rails_helper'


describe CurrencyConvert do
  let! (:target) { 'USD' }
  let! (:rates) { stub_rates(target: target) }

  let (:currency_hash) {
    {
      'BTC': rand(1..9.999).to_s,
      'ETH': rand(1..9.999).to_s
    }
  }

  describe 'convert' do
    it {
      converted_currency_hash = described_class.convert(currency_hash)
      expect(converted_currency_hash).to be_truthy
    }
  end

  describe 'rates' do
    it { expect(described_class.rates(target: target)).to be_truthy }
  end


end
