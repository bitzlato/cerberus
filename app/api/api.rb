class API < Grape::API
  format :json
  prefix 'api'


  mount Kyc
  mount Webhook
end