# frozen_string_literal: true

# Require JWT initializer to configure JWT key & options.
require_relative 'jwt'
require 'jwt/rack'

on_error = lambda do |_error|
  message = 'jwt.decode_and_verify'
  body    = { errors: [message] }.to_json
  headers = { 'Content-Type' => 'application/json', 'Content-Length' => body.bytesize.to_s }

  [401, headers, [body]]
end

# TODO: Fixme in jwt-rack handle api/v2// as api/v2.
auth_args = {
  secret: Rails.configuration.x.jwt_public_key,
  options: Rails.configuration.x.jwt_options,
  verify: Rails.configuration.x.jwt_public_key.present?,
  exclude: %w[/api/cerberus/webhook/sumsub /admin /assets /verifications],
  on_error: on_error
}

Rails.application.config.middleware.use JWT::Rack::Auth, auth_args

if Rails.env.development? && ENV.key?('DUMMY_JWT_BEARER')
  require 'dummy_jwt_middleware'
  Rails.logger.debug 'Use dummy JWT Bearer'
  Rails.application.config.middleware.insert_before JWT::Rack::Auth, DummyJwtMiddleware, bearer: ENV['DUMMY_JWT_BEARER']
end
