require 'rails_helper'


describe SumSub::GenerateUrl do
  describe 'generate link' do
    before do
      described_class.clear_cache
      @public_id = rand(99999)
      stub_websdk_link
    end

    it 'ok' do
      klass = described_class.new(public_id: @public_id)
      url = klass.call
      expect(url.include? 'https://api.sumsub.com/idensic/').to be true
    end
  end
end
