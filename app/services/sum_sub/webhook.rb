module SumSub
  # Service processing incoming webhook from sumsub
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
    end

    private

    def process_webhook
      if applicant.nil?
        Applicant.create!(attributes)
      else
        applicant.update(attributes)
      end
      set_status
    end

    def set_status
      status = 'verified' if review_answer == 'GREEN'
      status = 'banned'   if review_answer == 'RED' && review_reject_type == 'FINAL'
      status = 'rejected' if review_answer == 'RED' && review_reject_type == 'RETRY'
      status = 'init' if review_status == 'init'
      status = 'reseted' if webhook_type == 'applicantReset'
      applicant.update(status: status)
    end

    def attributes
      {
        sumsub_applicant_id: @params[:applicantId],
        inspection_id: @params[:inspectionId],
        user_uid: @params[:externalUserId],
        source_key: @params[:sourceKey],
        create_date: @params[:createdAt],
        reject_labels: @params.dig(:reviewResult, :rejectLabels),
        moderation_comment: @params.dig(:reviewResult, :moderationComment),
        client_comment: @params.dig(:reviewResult, :clientComment),
        review_reject_type: @params.dig(:reviewResult, :reviewRejectType),
        review_answer: @params.dig(:reviewResult, :reviewAnswer),
        review_status: @params.dig(:reviewStatus),
        webhook_type: @params[:type],
        sumsub_request: @params
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