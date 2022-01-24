class API < Grape::API
  format :json
  prefix 'api'


  mount Kyc
end