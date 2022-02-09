module CurrencyConvert
  RATE_CACHE_EXPIRE = 10.second
  class << self

  def initialize
  end

  def call
  end

  def rates(target: 'USD')
    Rails.cache.fetch("#{target}_currency_rate", expire_in: RATE_CACHE_EXPIRE ) do
      uri = URI("https://account.bitzlato.com/api/public/v1/rates?target_currency=#{target}")
      JSON.parse(Net::HTTP.get(uri)).dig('rates')
    end&.with_indifferent_access
  end

  end
end