require 'rails_helper'


describe SumSub::Webhook do

  describe 'validate' do
    before do
      @body = "{\n  \"applicantId\" : \"60a28411460647000a941c91\",\n  \"inspectionId\" : \"60a28411460647000a941c92\",\n  \"applicantType\" : \"individual\",\n  \"correlationId\" : \"req-44d4451a-fce1-4b5e-9fe4-6aaa201dd3f7\",\n  \"externalUserId\" : \"copy-58b35a13-61fb-469b-8f56-b1cab0c3f8f1\",\n  \"type\" : \"applicantReviewed\",\n  \"reviewResult\" : {\n    \"moderationComment\" : \"We cannot verify your profile. Please, contact support.\\n\\n\",\n    \"clientComment\" : \"Common comments:\\n\\nCriminal notes.\\n\",\n    \"reviewAnswer\" : \"RED\",\n    \"rejectLabels\" : [ \"CRIMINAL\", \"SANCTIONS\", \"COMPROMISED_PERSONS\", \"BLACKLIST\" ],\n    \"reviewRejectType\" : \"FINAL\"\n  },\n  \"reviewStatus\" : \"completed\",\n  \"createdAt\" : \"2022-01-25 07:35:48+0000\",\n  \"clientId\" : \"bitzlato\"\n}"
      ENV['SUMSUB_WEBHOOK_SECRET_KEY'] = '8ccj5ivpwku2u9by27otp969b9x'
      @secret = '8ccj5ivpwku2u9by27otp969b9x'
      @digest = 'ccfda551ed3ab0dc221952932ddf72050bd7707a'
      @hmac = OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('sha1'), @secret, @body)

    end
    it 'ok' do
      webhook = described_class.new(params: @params, body: @body, digest: @digest, validate_request: true, secret_key: @secret)
      expect( webhook.send(:validate_request)).to be_true
    end
    it 'fail' do
      webhook = described_class.new(params: @params, body: @body, digest: '1234', validate_request: true)
      expect{ webhook.send(:validate_request) }.to raise_error(SumSub::Webhook::InvalidRequest)
    end
  end

end