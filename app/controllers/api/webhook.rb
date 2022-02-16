# frozen_string_literal: true

# Webhook endpoints
module API
  class Webhook < Grape::API
    desc 'Incoming webhook from SumSub. Contains review result'
    params do
      requires :applicantId, type: String, desc: 'Applicant ID'
      requires :inspectionId, type: String, desc: 'Inspection ID (its a part of an applicant).'
      requires :correlationId, type: String, desc: 'This id uniquely identifies an event on our side.'
      requires :externalUserId, type: String, desc: 'Unique user Id on your side.'
      requires :type, type: String, desc: 'Webhook type.'
      requires :clientId, type: String, desc: 'Unique identifier of you as our client.'
      requires :reviewStatus, type: String, desc: 'Current status of an applicant. More info can be found here. https://developers.sumsub.com/api-reference/#getting-applicant-status-sdk'
      requires :createdAt, type: String, desc: 'Date and time of webhook creation (format YYYY-MM-dd hh:mm:ss, e.g. 2021-05-14 16:00:25+0000).'
      optional :applicantType, type: String, desc: 'Type of the applicant e.g. company/individual.'
      optional :reviewResult, type: JSON, desc: 'Field that contains extra information on applicant verification results.'
      optional :applicantMemberOf, type: JSON, desc: 'Contains the list of company applicantIds that current applicant belongs as a beneficiary.'
      optional :videoIdentReviewStatus, type: JSON, desc: 'Status of the videoIdent call.'
      optional :applicantActionId, type: JSON, desc: 'Id of an applicant action.'
      optional :externalApplicantActionId, type: JSON, desc: 'Unique action Id on your side'
    end
    post 'sumsub' do
      Rails.logger.info "Incoiming webhook: #{@params}"
      digest = request.headers['X-Payload-Digest']
      webhook = SumSub::Webhook.new(
        params: @params,
        body: request.body.string,
        digest: digest,
        validate_request: !Rails.env.test?
        )
      webhook.call
    end
  end
end
