# frozen_string_literal: true

# KYC endpoints
class Kyc < Grape::API
  resource :kyc do
    desc 'Get verification KYC url for current user'
    post 'verification_url' do
      url = SumSub::GenerateUrl.new(user_id: current_user_uid).call
      response = {url: url}

      present response
    end

    desc 'Get kyc status info for current user'
    get 'status' do
      applicant = Applicant.find_by_user_uid(current_user_uid)
      unless applicant
        create_response = Applicant.init_applicant(current_user_uid)
        sleep 0.3 # Time for webhook
        applicant = Applicant.find_by_user_uid(current_user_uid)
        raise "Applicant not created after init_applicant: #{create_response}" if applicant.nil?
      end

      present applicant.as_json(only: [:status, :reject_labels, :client_comment, :review_status, :start_date])
    end

    desc 'Reset KYC verification in sumsub'
    post 'reset' do
      applicant = Applicant.find_by(user_uid: current_user_uid)
      response = { reset: applicant.reset_applicant }
      present response
    end
  end
end
