# frozen_string_literal: true

# KYC endpoints
class Kyc < Grape::API
  resource :kyc do
    desc 'Get verification KYC url for current user'
    params do
      requires :user_id, type: String, desc: 'Unique user ID'
    end
    get 'verification_url' do
      #TODO: заменить на какую нибудь прослойку
      request = Sumsub::Request.new.generate_external_link('basic-kyc-level', 3600, params[:id], locale: 'en')
      present request
    end
  end
end
