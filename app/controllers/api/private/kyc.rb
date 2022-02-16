# frozen_string_literal: true

# KYC endpoints
module API
  module Private
    class KYC < Grape::API
      resource :kyc do
        desc 'Get verification KYC url for current user'
        post 'verification_url' do
          url = SumSub::GenerateUrl.new(applicant_id: current_user_uid).call
          response = {url: url}

          present response
        end

        desc 'Get kyc status info for current user'
        get 'status' do
          applicant = Applicant.find_by_user_uid(current_user_uid)
          unless applicant
            applicant = Applicant.init_applicant(current_user_uid)
            raise "Applicant not created after init_applicant: #{create_response}" if applicant.nil?
          end

          present applicant.as_json(only: [:status, :reject_labels, :client_comment, :review_status])
        end
      end
    end
  end
end