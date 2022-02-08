module ConvertRate
  RATE_CACHE_EXPIRE = 10.second
  class << self

    def initialize
    end


    def call
    end


    def get_rates
      Rails.cache.fetch('usd_convert_rate', expire_in: RATE_CACHE_EXPIRE ) do
        uri = URI('https://account.bitzlato.com/api/public/v1/rates?target_currency=USD')
        JSON.parse(Net::HTTP.get(uri)).dig('rates')
      end
    end

  end
end