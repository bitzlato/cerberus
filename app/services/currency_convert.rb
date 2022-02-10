module CurrencyConvert
  RATE_CACHE_EXPIRE_IN = 10.second
  class << self

    # Convere and Summarize collection of currencies in all available currency
    #
    # Example input: currency_hash: {'BTC':'0.01', ETH: '3.23'}
    # Converts BTC and ETH in usd and Summarize. Then convert sum in usd in available currency in system
    #
    # Example output: {"USDC"=>73807.26214321014, "LTC"=>10171009.759645075, "BCH"=>25124065.840810876, "DAI"=>73954.87666749656, "USDT"=>73865.56988030329, "BTC"=>3208709468.808073, "MCR"=>987.2267485394217, "MDT"=>135805.36234350668, "DOGE"=>11558.95532424814, "DASH"=>8414671.483651845, "ETH"=>229191764.64311188, "AVAX"=>73807.26214321014, "BNB-BEP20"=>30617890.751498997, "DAI-ERC20"=>73807.26214321014, "HT-HRC20"=>737903.0668969859, "MATIC"=>142511.80063870782, "MCR-ERC20"=>985.0698542095417, "MDT-ERC20"=>145396.66147675068, "UNI-ERC20"=>73807.26214321014, "USDC-BEP20"=>73776.32522801189, "USDC-ERC20"=>73753.78362552238, "USDC-HRC20"=>73768.48194614933, "USDC-PLGN"=>73732.01414746595, "USDCE-ARC20"=>73807.26214321014, "USDT-BEP20"=>73779.31855685725, "USDT-ERC20"=>73807.26214321014, "USDT-HRC20"=>73785.09845014704, "USDT-PLGN"=>73813.51453018638, "USDTE-ARC20"=>73807.26214321014, "WAVAX-ARC20"=>73807.26214321014}
    def convert(currency_hash)
      result = {}
      in_usd = summarize_сurrency(currency_hash)
      currencies.each do |rate_key, rate_value|
        result[rate_key] = reverse_convert_unit(rate_key, in_usd)
      end
      result
    end

    def rates(target: 'USD')
      target = target.upcase
      Rails.cache.fetch("#{target}_currency_rate", expire_in: RATE_CACHE_EXPIRE_IN ) do
        uri = URI("https://account.bitzlato.com/api/public/v1/rates?target_currency=#{target}")
        JSON.parse(Net::HTTP.get(uri)).dig('rates')
      end&.with_indifferent_access
    end

    def currencies
      @currencies ||= rates.keys
    end

    private

    # Convert and Summarize all currency in parameter in one currency(USDC)
    def summarize_сurrency(currency_hash)
      amount = 0
      currency_hash.each do |key, value|
        amount += convert_unit(key, value)
      end
      amount
    end

    def convert_unit(key, value)
      rates[key].to_f * value.to_f
    end

    def reverse_convert_unit(key, value)
      raise 'Zero Currency Value division' if value.zero?
      value.to_f / rates[key].to_f
    end
  end
end