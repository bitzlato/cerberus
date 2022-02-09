module CurrencyConvert
  RATE_CACHE_EXPIRE_IN = 10.second
  class << self

  def convert(currency_hash)
    return 1
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


  end
end