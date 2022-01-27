# frozen_string_literal: true

# KYC endpoints
class Kyc < Grape::API
  resource :kyc do
    desc 'Get verification KYC url for current user'
    params do
      requires :user_id, type: String, desc: 'Unique user ID'
    end
    get 'verification_url' do
      url = SumSub::GenerateUrl.new(user_id: params[:user_id]).call
      response = {url: url}
      present response
    end
  end
end
