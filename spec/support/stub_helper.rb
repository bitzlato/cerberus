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

  def stub_create_applicant(user_id: 1111, body: nil)
    response = body || {"id"=>"61fcc341e552bf0001086cf8", "createdAt"=>"2022-02-04 06:10:09", "key"=>"KSXCVFKHEPLNFP", "clientId"=>"bitzlato", "inspectionId"=>"61fcc341e552bf0001086cf9", "externalUserId"=>user_id, "info"=>{}, "requiredIdDocs"=>{"excludedCountries"=>["AFG", "ALB", "AGO", "DZA", "BGD", "BRB", "BOL", "BWA", "BDI", "KHM", "CAF", "TCD", "COG", "CIV", "CUB", "PRK", "ECU", "EGY", "GNQ", "ERI", "GHA", "GNB", "GUY", "USA", "HTI", "IRN", "IRQ", "JAM", "LAO", "LBN", "LBY", "MLI", "MAR", "NPL", "NIC", "MKD", "PAK", "PAN", "QAT", "SAU", "SOM", "SSD", "SDN", "SYR", "TUN", "UGA", "VUT", "VEN", "YEM", "ZWE", "COD"], "docSets"=>[{"idDocSetType"=>"IDENTITY", "types"=>["PASSPORT", "DRIVERS", "ID_CARD"], "subTypes"=>["FRONT_SIDE", "BACK_SIDE"]}, {"idDocSetType"=>"SELFIE", "types"=>["SELFIE"], "videoRequired"=>"passiveLiveness"}]}, "review"=>{"reviewId"=>"AZwfB", "attemptId"=>"rdHKS", "attemptCnt"=>0, "reprocessing"=>false, "levelName"=>"basic-kyc-level", "createDate"=>"2022-02-04 06:10:09+0000", "reviewStatus"=>"init", "priority"=>0, "autoChecked"=>false}, "type"=>"individual"}
    request_signature = stub_request(:post, "https://test-api.sumsub.com/resources/applicants?levelName=basic-kyc-level").
      to_return(status: 200, body: response.to_json, headers: {})
  end

  def stub_rates(body: nil, target: 'USD')
    rate =
      {
        "target_currency": target,
        "rates": {
          "USDC": "1.0",
          "LTC": "2",
          "BCH": "2",
          "DAI": "2",
          "USDT": "2",
          "BTC": "2",
          "ETH": "2",
          "MCR": "2",
          "MDT": "2",
          "DOGE": "2",
          "DASH": "2",
          "AVAX": "2",
          "BNB-BEP20": "2",
          "DAI-ERC20": "2",
          "HT-HRC20": "2",
          "MATIC": "2",
          "MCR-ERC20": "2",
          "MDT-ERC20": "2",
          "UNI-ERC20": "2",
          "USDC-BEP20": "2",
          "USDC-ERC20": "2",
          "USDC-HRC20": "2",
          "USDC-PLGN": "2",
          "USDCE-ARC20": "2.0",
          "USDT-BEP20": "2",
          "USDT-ERC20": "2",
          "USDT-HRC20": "2",
          "USDT-PLGN": "2",
          "USDTE-ARC20": "2",
          "WAVAX-ARC20": "2"
        },
        "at": Time.now.utc.iso8601
      }
    response = body || rate
    stub_request(:get, "https://account.bitzlato.com/api/public/v1/rates?target_currency=#{target}").
      to_return(status: 200, body:  response.to_json, headers: {})
    response
  end

end