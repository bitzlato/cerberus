module SumSub
  class Webhook
    class InvalidRequest < StandardError; end

    def initialize(params:, body: nil, digest: nil, validate_request: true, secret_key: nil)
      @params = params
      @validate_request = validate_request
      @body = body
      @digest = digest
      @secret_key = secret_key || ENV.fetch('SUMSUB_WEBHOOK_SECRET_KEY', '')
    end

    def call
      validate_request if @validate_request
      process_webhook
    rescue InvalidRequest
    end

    private

    def process_webhook
       if applicant.nil?
         Applicant.create!(attributes_matcher)
       else
         applicant.update(attributes_matcher)
       end
    end

    def attributes_matcher
      {
        applicant_id: @params[:applicantId],
        inspection_id: @params[:inspectionId],
        user_uid: @params[:externalUserId],
        source_key: @params[:sourceKey],
        create_date: @params[:createdAt],
        reject_labels: @params[:reviewResult][:rejectLabels],
        moderation_comment: @params[:reviewResult][:moderationComment],
        client_comment: @params[:reviewResult][:clientComment],
        review_reject_type: @params[:reviewResult][:reviewRejectType],
        review_answer: @params[:reviewResult][:reviewAnswer],
        review_status: @params[:reviewResult][:reviewStatus],
        raw_request: @params
      }
    end

    def applicant
      @applicant ||= Applicant.find_by_applicant_id(@params[:applicantId])
    end

    def validate_request
      hmac = OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('sha1'), @secret_key, @body)

      if hmac == @digest
        true
      else
        raise InvalidRequest
      end
    end
  end
end