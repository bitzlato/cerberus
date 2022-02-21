module StubHelper

  def stub_websdk_link(body: nil)
    response = body || { "url": "https://api.sumsub.com/idensic/l/#/#{SecureRandom.hex}" }
    stub_request(:post, %r(externalUserId=\S+\&)).
      to_return(status: 200, body: response.to_json, headers: {})
    response
  end

  def stub_reset(public_id: 1111, body: nil)
    response = body || {'ok': 1}
    stub_request(:post, "https://test-api.sumsub.com/resources/applicants/#{public_id}/reset").
      to_return(status: 200, body: response.to_json, headers: {})
  end

  def stub_create_applicant(public_id: 1111, body: nil)
    response = body || { "id"=>"61fcc341e552bf0001086cf8", "createdAt"=>"2022-02-04 06:10:09", "key"=>"KSXCVFKHEPLNFP", "clientId"=>"bitzlato", "inspectionId"=>"61fcc341e552bf0001086cf9", "externalUserId"=>public_id, "info"=>{}, "requiredIdDocs"=>{ "excludedCountries"=>["AFG", "ALB", "AGO", "DZA", "BGD", "BRB", "BOL", "BWA", "BDI", "KHM", "CAF", "TCD", "COG", "CIV", "CUB", "PRK", "ECU", "EGY", "GNQ", "ERI", "GHA", "GNB", "GUY", "USA", "HTI", "IRN", "IRQ", "JAM", "LAO", "LBN", "LBY", "MLI", "MAR", "NPL", "NIC", "MKD", "PAK", "PAN", "QAT", "SAU", "SOM", "SSD", "SDN", "SYR", "TUN", "UGA", "VUT", "VEN", "YEM", "ZWE", "COD"], "docSets"=>[{ "idDocSetType"=>"IDENTITY", "types"=>["PASSPORT", "DRIVERS", "ID_CARD"], "subTypes"=>["FRONT_SIDE", "BACK_SIDE"]}, { "idDocSetType"=>"SELFIE", "types"=>["SELFIE"], "videoRequired"=>"passiveLiveness"}]}, "review"=>{ "reviewId"=>"AZwfB", "attemptId"=>"rdHKS", "attemptCnt"=>0, "reprocessing"=>false, "levelName"=>"basic-kyc-level", "createDate"=>"2022-02-04 06:10:09+0000", "reviewStatus"=>"init", "priority"=>0, "autoChecked"=>false}, "type"=>"individual"}
    request_signature = stub_request(:post, "https://test-api.sumsub.com/resources/applicants?levelName=basic-kyc-level").
      to_return(status: 200, body: response.to_json, headers: {})
    response
  end

  def stub_rates(body: nil, target: 'USD')
    rate =
      {
        "target_currency": target,
        "rates": {
          "USDC": "1.0",
          "LTC": rand_currency,
          "BCH": rand_currency,
          "DAI": rand_currency,
          "USDT": rand_currency,
          "BTC": rand_currency,
          "ETH": rand_currency,
          "MCR": rand_currency,
          "MDT": rand_currency,
          "DOGE": rand_currency,
          "DASH": rand_currency,
          "AVAX": rand_currency,
          "BNB-BEP20": rand_currency,
          "DAI-ERC20": rand_currency,
          "HT-HRC20": rand_currency,
          "MATIC": rand_currency,
          "MCR-ERC20": rand_currency,
          "MDT-ERC20": rand_currency,
          "UNI-ERC20": rand_currency,
          "USDC-BEP20": rand_currency,
          "USDC-ERC20": rand_currency,
          "USDC-HRC20": rand_currency,
          "USDC-PLGN": rand_currency,
          "USDCE-ARC20": rand_currency,
          "USDT-BEP20": rand_currency,
          "USDT-ERC20": rand_currency,
          "USDT-HRC20": rand_currency,
          "USDT-PLGN": rand_currency,
          "USDTE-ARC20": rand_currency,
          "WAVAX-ARC20": rand_currency
        },
        "at": Time.now.utc.iso8601
      }
    response = body || rate
    stub_request(:get, "https://account.bitzlato.com/api/public/v1/rates?target_currency=#{target}").
      to_return(status: 200, body:  response.to_json, headers: {})
    response
  end

  private

  def rand_currency
    rand(1..99.999999).to_s
  end

end