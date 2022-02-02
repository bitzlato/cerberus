class API < Grape::API
  format :json
  prefix 'api'


  rescue_from ActiveRecord::RecordNotFound do |e|
    error_response(message: e.message, status: 404)
  end

  rescue_from ActiveRecord::RecordInvalid do |e|
    error_response(message: e.message, status: 422)
  end

  rescue_from StandardError do |e|
    error_response(message: e.message, status: 500)
  end

  rescue_from SumSub::Webhook::InvalidRequest do |e|
    error_response(message: 'Unverified webhook', status: 401)
  end

  helpers ::CurrentUser
  mount Kyc
  mount Webhook
end
