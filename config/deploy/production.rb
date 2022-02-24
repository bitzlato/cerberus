# frozen_string_literal: true

set :stage, :production
set :rails_env, :production
fetch(:default_env)[:rails_env] = :production

set :disallow_pushing, false
set :application, -> { 'cerberus-' + fetch(:stage).to_s }
set :deploy_to, -> { "/home/#{fetch(:user)}/#{fetch(:stage)}/#{fetch(:application)}" }


server ENV.fetch('PRODUCTION_SERVER'),
       user: 'app',
       port: '22',
       roles: %w[app db].freeze,
       ssh_options: { forward_agent: true }
