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

    desc 'Reset KYC verification in sumsub'
    params do
      requires :user_id, type: String, desc: 'Unique user ID'
    end
    post 'reset' do
      applicant = Applicant.find_by(user_uid: @params[:user_id])
      response = { reset: applicant.reset_applicant }
      present response
    end
  end
end
