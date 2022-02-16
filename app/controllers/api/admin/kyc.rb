# frozen_string_literal: true

# KYC endpoints
module API
  module Admin
    class KYC < Grape::API
      resource :kyc do
        desc '123 '
        get 'test' do
          present 'test'
        end
        desc 'Reset KYC verification in sumsub'
        post 'reset' do
          applicant = Applicant.find_by(user_uid: current_user_uid)
          response = { reset: applicant.reset_applicant }
          present response
        end
      end
    end
  end
end

