Sumsub.configure do |config|
  config.token = ENV.fetch('SUMSUB_TOKEN', '')
  config.secret_key = ENV.fetch('SUMSUB_SECRET', '')
  config.production = ActiveModel::Type::Boolean.new.cast(ENV.fetch('SUMSUB_PRODUCTION', false))
end