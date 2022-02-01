# Copyright (c) 2019 Danil Pismenny <danil@brandymint.ru>

# frozen_string_literal: true

set :stage, :sandbox
set :user, 'app'
set :deploy_to, -> { "/home/#{fetch(:user)}/sandbox/#{fetch(:application)}" }
append :linked_files, 'config/credentials/sandbox.key'

server '141.94.218.39',
       user: fetch(:user),
       roles: fetch(:roles),
       ssh_options: { forward_agent: true }