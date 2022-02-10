module CurrencyConvert
  RATE_CACHE_EXPIRE_IN = 10.second
  class << self

    # Convere and Summarize collection of currencies in all available currency
    #
    # Example input: currency_hash: {'BTC':'1.0', ETH: '1.0'}
    # Converts BTC and ETH in usd and Summarize. Then convert sum in usd in available currency in system
    #
    # Example output: {"BTC"=>1.072375778782122, "DASH"=>414.18117686107996, "MDT"=>25006.164447204923, "ETH"=>14.816777060325297, "USDC"=>47261.6508052173, "USDT"=>47233.310818726066, "BCH"=>136.34295952901098, "DAI"=>47361.11957577273, "LTC"=>340.1782944549658, "DOGE"=>300493.7106130296, "MCR"=>3530163.3786514965, "AVAX"=>47261.6508052173, "BNB-BEP20"=>112.19848081579256, "DAI-ERC20"=>47261.6508052173, "HT-HRC20"=>4726.3533664773295, "MATIC"=>23852.049681298045, "MCR-ERC20"=>3535734.1665345803, "MDT-ERC20"=>23074.556696603, "UNI-ERC20"=>47261.6508052173, "USDC-BEP20"=>47301.742788835014, "USDC-ERC20"=>47296.80289525979, "USDC-HRC20"=>47298.56506998298, "USDC-PLGN"=>47280.678844779, "USDCE-ARC20"=>47261.6508052173, "USDT-BEP20"=>47252.529620938054, "USDT-ERC20"=>47261.6508052173, "USDT-HRC20"=>47252.25885043067, "USDT-PLGN"=>47234.87396049039, "USDTE-ARC20"=>47261.6508052173, "WAVAX-ARC20"=>47261.6508052173}
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