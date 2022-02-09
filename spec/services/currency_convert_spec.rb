require 'rails_helper'


describe CurrencyConvert do
  describe 'rates' do
    it 'ok' do
      rates = stub_rates
      expect(described_class.rates).to be_truthy
    end
  end
end
