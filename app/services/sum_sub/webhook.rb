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
      status = 'verified' if @params.dig(:reviewResult, :reviewAnswer) == 'GREEN'
      status = 'banned'   if @params.dig(:reviewResult, :reviewAnswer) == 'RED' && @params.dig(:reviewResult, :reviewRejectType) == 'FINAL'
      status = 'rejected' if @params.dig(:reviewResult, :reviewAnswer) == 'RED' && @params.dig(:reviewResult, :reviewRejectType) == 'RETRY'
      status = 'init'     if @params.dig(:reviewStatus) == 'init'
      status = 'reseted'  if @params[:type] == 'applicantReset'
      applicant.update(status: status)
    end

    def attributes
      {
        sumsub_applicant_id: @params[:applicantId],
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