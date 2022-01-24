require 'rails_helper'


describe SumSub::GenerateUrl do
    it 'ok' do
      klass = described_class.new(user_id: rand(9999))
      url = klass.call
      expect(url.include? 'https://test-api.sumsub.com/idensic/').to be true
    end
end