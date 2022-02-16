module API
  module Private
    class Mount < Grape::API
      default_format :json
      format         :json
      content_type   :json, 'application/json'

      include API::ErrorsHandler
      helpers API::Helpers::CurrentUser
      mount API::Private::KYC
    end
  end
end