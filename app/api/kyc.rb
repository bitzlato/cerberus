# frozen_string_literal: true

# KYC endpoints
class Kyc < Grape::API
  resource :kyc do
    desc 'Get verification KYC url for current user'
    params do
      #requires :user_id, type: String, desc: 'Unique user ID'
    end
    post 'verification_url' do
      url = SumSub::GenerateUrl.new(user_id: current_user_uid).call
      response = {url: url}
      #201
      present response
    end

    desc 'Reset KYC verification in sumsub'
    params do
      # requires :user_id, type: String, desc: 'Unique user ID'
    end
    post 'reset' do
      applicant = Applicant.find_by(user_uid: current_user_uid)
      response = { reset: applicant.reset_applicant }
      present response
    end
  end
end
