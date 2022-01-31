class API < Grape::API
  format :json
  prefix 'api'

  helpers ::CurrentUser

  mount Kyc
  mount Webhook
end