# frozen_string_literal: true

# KYC endpoints
module API
  module Admin
    class Verifications < Grape::API
      resource :verifications do
        desc 'Applicant Inddex'
        get do
          present 'applicant index'
        end

        desc 'Reset KYC verification in sumsub'
        route_param :uid do
          desc 'Get Applicant by uid'
          get do
            applicant = Applicant.find_by(uid: params[:uid])
            present applicant.as_json
          end
          get 'reset' do
            applicant = Applicant.find_by(uid: params[:uid])
            response = { reset: applicant.reset_applicant }
            present response
          end
        end
      end
    end
  end
end

