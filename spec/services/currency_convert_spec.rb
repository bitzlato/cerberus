require 'rails_helper'


describe CurrencyConvert do
  describe 'rates' do
    let! (:target) { 'USD' }
    let! (:rates) { stub_rates(target: target) }

    it { expect(described_class.rates(target: target)).to be_truthy }
  end
end
