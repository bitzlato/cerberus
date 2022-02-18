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
      status = 'verified' if review_result == 'GREEN'
      status = 'banned'   if review_result == 'RED' && review_reject_type == 'FINAL'
      status = 'rejected' if review_result == 'RED' && review_reject_type == 'RETRY'
      status = 'init'     if review_status == 'init'
      status = 'reseted'  if @params[:type] == 'applicantReset'
      applicant.update(status: status)
    end

    def attributes
      {
        sumsub_applicant_id: @params[:applicantId],
        sumsub_request: @params
      }
    end

    def review_reject_type
      @params.dig(:reviewResult, :reviewRejectType)
    end

    def review_status
      @params.dig(:reviewStatus)
    end

    def review_result
      @params.dig(:reviewResult, :reviewAnswer)
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