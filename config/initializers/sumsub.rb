Sumsub.configure do |config|
  config.token = Rails.application.credentials.dig(:sumsub, :token)
  config.secret_key = Rails.application.credentials.dig(:sumsub, :secret)
  config.production = Rails.application.credentials.dig(:sumsub, :production)
end