module API
  module Public
    class Mount < Grape::API
      default_format :json
      format         :json
      content_type   :json, 'application/json'

      include API::ErrorsHandler
    end
  end
end