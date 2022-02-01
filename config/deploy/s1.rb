# frozen_string_literal: true

set :user, 'app'

set :rails_env, :staging
set :disallow_pushing, false
set :application, -> { 'kyc-service-' + fetch(:stage).to_s }
set :deploy_to, -> { "/home/#{fetch(:user)}/#{fetch(:stage)}/#{fetch(:application)}" }
append :linked_files, 'config/credentials/staging.key'
set :puma_bind, -> { ["tcp://0.0.0.0:961#{fetch(:stage)[1].to_i || 9}", "unix://#{shared_path}/tmp/sockets/puma.sock"] }

server ENV.fetch('STAGING_SERVER'),
       user: fetch(:user),
       roles: fetch(:roles),
       ssh_options: { forward_agent: true }