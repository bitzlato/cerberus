module API
  module Admin
    class Mount < Grape::API
      default_format :json
      format         :json
      content_type   :json, 'application/json'

      include API::ErrorsHandler
      mount API::Admin::KYC
    end
  end
end