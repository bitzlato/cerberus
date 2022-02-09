require 'rails_helper'


describe CurrencyConvert do
  let! (:target) { 'USD' }
  let! (:rates) { stub_rates(target: target).with_indifferent_access }

  let (:currency_hash) {
    {
      'BTC': rand(1..9.999).to_s,
      'ETH': rand(1..9.999).to_s,
      'USDT': rand(1..9.999).to_s,
      'BCH': rand(1..9.999).to_s,
      'DAI': rand(1..9.999).to_s,
      'USDC-BEP20': rand(1..9.999).to_s,
    }.with_indifferent_access
  }

  describe 'convert' do
    it 'all currencies correct' do
      converted_currency_hash = described_class.convert(currency_hash)


      CurrencyConvert.currencies do |in_currency_tag|
        in_currency = 0
        currency_hash.each do |key, value|
          in_currency += currency_hash[key].to_f*rates['rates'][key].to_f
        end
        
        expect(converted_currency_hash[in_currency_tag]).to eq in_currency
      end
    end
  end

  describe 'rates' do
    it { expect(described_class.rates(target: target)).to be_truthy }
  end
end
