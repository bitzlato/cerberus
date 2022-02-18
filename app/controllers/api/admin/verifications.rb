# frozen_string_literal: true

# KYC endpoints
module API
  module Admin
    class Verifications < Grape::API
      resource :verifications do
        desc 'Applicant Index'
        get do
          present 'applicant index'
        end

        desc 'Reset KYC verification in sumsub'
        route_param :id do
          desc 'Get Applicant by id'
          get do
            applicant = Applicant.find_by(id: params[:id])
            present applicant.as_json
          end
          get 'reset' do
            applicant = Applicant.find_by(id: params[:id])
            response = { reset: applicant.reset_applicant }
            present response
          end
        end
      end
    end
  end
end

