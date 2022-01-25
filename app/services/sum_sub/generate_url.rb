# frozen_string_literal: true

module SumSub
  # Generate Url to SumSub verification form
  class GenerateUrl

    def initialize(user_id: , locale: 'en', level_name: 'basic-kyc-level', ttl: 3600)
      @user_id = user_id
    @locale = locale
      @level_name = level_name
      @ttl = ttl
    end

    def call
      response = request.generate_external_link(
                          @level_name,
                          @ttl,
                          @user_id,
                          locale: @locale
                        )

      response['url']
    end

    private

    def request
      Sumsub::Request.new
    end

  end
end
