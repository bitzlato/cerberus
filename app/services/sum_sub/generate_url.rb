# frozen_string_literal: true

module SumSub
  # Generate Url to SumSub verification form
  class GenerateUrl
    @@cached_url = {}

    CACHE_TIME = 10.minutes

    def initialize(user_id: , locale: 'en', level_name: 'basic-kyc-level', ttl: 3600)
      @user_id = user_id
      @locale = locale
      @level_name = level_name
      @ttl = ttl
    end

    def call
      read_cache || write_cache(execute_api)
    end

    def self.clear_cache
      @@cached_url = {}
    end

    private

    def execute_api
      response = request.generate_external_link(
        @level_name,
        @ttl,
        @user_id,
        locale: @locale
      )
      response['url']
    end

    def read_cache
      cache = @@cached_url[@user_id]
      return cache[:url] if cache && (cache[:generated_at] + CACHE_TIME) > Time.now
    end

    def write_cache(url)
      @@cached_url[@user_id] = {
        url: url,
        generated_at: Time.now
      }
      url
    end

    def request
      Sumsub::Request.new
    end
  end
end
