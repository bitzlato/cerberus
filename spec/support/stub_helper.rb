module StubHelper

  def stub_websdk_link(user_id: 1111, body: nil)
    response = body || { "url": "https://api.sumsub.com/idensic/l/#/#{SecureRandom.hex}" }
    stub_request(:post, "https://test-api.sumsub.com/resources/sdkIntegrations/levels/basic-kyc-level/websdkLink?externalUserId=#{user_id}&lang=en&ttlInSecs=3600").
      to_return(status: 200, body: response.to_json, headers: {})
    response
  end

  def stub_reset(applicant_id: 1111, body: nil)
    response = body || {'ok': 1}
    stub_request(:post, "https://test-api.sumsub.com/resources/applicants/#{applicant_id}/reset").
      to_return(status: 200, body: response.to_json, headers: {})
  end
end