# frozen_string_literal: true

# KYC endpoints
module API
  module Private
    class KYC < Grape::API
      resource :kyc do
        desc 'Get verification KYC url for current user'
        post 'verification' do
          applicant = Applicant.find_or_create_by(barong_uid: current_user_uid)
          url = SumSub::GenerateUrl.new(applicant_id: applicant.applicant_id).call
          response = {url: url}

          present response
        end

        desc 'Get kyc status info for current user'
        get 'verification' do
          applicant = Applicant.find_by(barong_uid: current_user_uid)
          unless applicant
            applicant = Applicant.init_applicant(current_user_uid)
            raise "Applicant not created after init_applicant: " if applicant.nil?
          end

          present applicant.as_json(only: [:status, :reject_labels, :client_comment, :review_status])
        end
      end
    end
  end
end