module CurrencyConvert
  RATE_CACHE_EXPIRE_IN = 100.second
  class << self

  def convert(currency_hash)
    result = {}
    currencies.each do |rate_key, rate_value|
      result[rate_key] = convert_unit(rate_key, summarize_сurrency(currency_hash))
    end
    result
  end

  def rates(target: 'USD')
    target = target.upcase
    Rails.cache.fetch("#{target}_currency_rate", expire_in: RATE_CACHE_EXPIRE_IN ) do
      uri = URI("https://account.bitzlato.com/api/public/v1/rates?target_currency=#{target}")
      p JSON.parse(Net::HTTP.get(uri)).dig('rates')
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
  end
end