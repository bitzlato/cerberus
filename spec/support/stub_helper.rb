module StubHelper

  def stub_websdk_link(user_id: 1111, body: nil)
    response = body || { "url": "https://api.sumsub.com/idensic/l/#/lPDnIKwzmxPfDohk" }
    stub_request(:post, "https://test-api.sumsub.com/resources/sdkIntegrations/levels/basic-kyc-level/websdkLink?externalUserId=#{user_id}&lang=en&ttlInSecs=3600").
      to_return(status: 200, body: response.to_json, headers: {})
    response
  end
end