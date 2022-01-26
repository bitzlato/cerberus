require 'rails_helper'


describe SumSub::GenerateUrl do
  before do
    response = {
      "url": "https://api.sumsub.com/idensic/l/#/lPDnIKwzmxPfDohk"
    }
    stub_request(:post, "https://test-api.sumsub.com/resources/sdkIntegrations/levels/basic-kyc-level/websdkLink?externalUserId=1111&lang=en&ttlInSecs=3600").
      to_return(status: 200, body: response.to_json, headers: {})
  end
    it 'ok' do
      klass = described_class.new(user_id: 1111)
      url = klass.call
      expect(url.include? 'https://api.sumsub.com/idensic/').to be true
    end
end