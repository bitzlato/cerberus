require 'rails_helper'


describe SumSub::GenerateUrl do
  before do
    @user_id=rand(99999)
    stub_websdk_link(user_id: @user_id)
  end
    it 'ok' do
      klass = described_class.new(user_id: @user_id)
      url = klass.call
      expect(url.include? 'https://api.sumsub.com/idensic/').to be true
    end
end