Sumsub.configure do |config|
  config.token = ENV.fetch('SUMSUB_TOKEN', '')
  config.secret_key = ENV.fetch('SUMSUB_SECRET', '')
  config.production = false # is true by default
end