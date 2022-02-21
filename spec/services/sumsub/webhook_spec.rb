require 'rails_helper'

describe SumSub::Webhook do
  describe 'create applicant' do
    before do
      @params = {
        'applicantId': '61979799a898020001300fc2',
        'inspectionId': '61979799a898020001300fc3',
        'applicantType': 'individual',
        'correlationId': 'req-93309875-9699-4eae-8fb4-e4985d8a0ac0',
        'externalUserId': '14577264',
        'type': 'applicantReviewed',
        'reviewResult': {
          'moderationComment': 'Пожалуйста, укажите дату рождения в точности так, как она указана в вашем удостоверении личности.',
          'clientComment': 'The date of birth on the profile is either missing or incorrect.',
          'reviewAnswer': 'RED',
          'rejectLabels': ['PROBLEMATIC_APPLICANT_DATA'],
          'reviewRejectType': 'RETRY'
        },
        'reviewStatus': 'completed',
        'createdAt': '2022-01-25 13:09:11+0000',
        'sourceKey': '',
        'clientId': 'bitzlato'
      }.with_indifferent_access
      @applicant = create(:applicant, :init, sumsub_applicant_id: @params['applicantId'])
    end
    it 'ok' do
      webhook = described_class.new(
        params: @params,
        validate_request: false
      )
      webhook.call
      applicant = Applicant.last
      expect(applicant.sumsub_applicant_id).to eq @params['applicantId']
      expect(applicant.status).to eq 'rejected'
    end
  end

  describe 'reset applicant' do
    before do
      @applicant = create(:applicant, :verified)
      @params = {
        "applicantId": "5f194e74040c3f316bda271c",
        "inspectionId": "5f194e74040c3f316bda271d",
        "applicantType": "individual",
        "correlationId": "req-57fed49a-07b8-4413-bdaa-a1be903769e9",
        "externalUserId": "12672",
        "type": "applicantReset",
        "reviewResult": {
          "reviewAnswer": "GREEN"
        },
        "reviewStatus": "init",
        "createdAt": "2021-03-01 11:34:51+0000",
        "clientId": "SumsubClient"
      }.with_indifferent_access
      @applicant = create(:applicant, :init, sumsub_applicant_id: @params['applicantId'])
    end

    it 'ok' do
      webhook = described_class.new(
        params: @params,
        validate_request: false
      )

      webhook.call
      expect(Applicant.last.status).to eq('reseted')
    end
  end

  describe 'change applicant' do
    before do
      @params = {
        'applicantId': 'f194e74040c3f316bda271c',
        'inspectionId': '231',
        'applicantType': 'individual',
        'correlationId': 'req-93309875-9699-4eae-8fb4-e4985d8a0ac0',
        'externalUserId': '14577264',
        'type': 'applicantReviewed',
        'reviewResult': {
          'reviewAnswer': 'GREEN',
        },
        'reviewStatus': 'completed',
        'createdAt': '2022-01-25 13:09:11+0000',
        'sourceKey': '',
        'clientId': 'bitzlato'
      }.with_indifferent_access
      @applicant = create(:applicant, :rejected, sumsub_applicant_id: @params['applicantId'])
    end

    it 'ok' do
      webhook = described_class.new(
        params: @params,
        validate_request: false
      )
      webhook.call
      @applicant.reload
      expect(@applicant.status).to eq('verified')
    end
  end

  describe 'validate' do
    before do
      @body = "{\n  \"applicantId\" : \"60a28411460647000a941c91\",\n  \"inspectionId\" : \"60a28411460647000a941c92\",\n  \"applicantType\" : \"individual\",\n  \"correlationId\" : \"req-44d4451a-fce1-4b5e-9fe4-6aaa201dd3f7\",\n  \"externalUserId\" : \"copy-58b35a13-61fb-469b-8f56-b1cab0c3f8f1\",\n  \"type\" : \"applicantReviewed\",\n  \"reviewResult\" : {\n    \"moderationComment\" : \"We cannot verify your profile. Please, contact support.\\n\\n\",\n    \"clientComment\" : \"Common comments:\\n\\nCriminal notes.\\n\",\n    \"reviewAnswer\" : \"RED\",\n    \"rejectLabels\" : [ \"CRIMINAL\", \"SANCTIONS\", \"COMPROMISED_PERSONS\", \"BLACKLIST\" ],\n    \"reviewRejectType\" : \"FINAL\"\n  },\n  \"reviewStatus\" : \"completed\",\n  \"createdAt\" : \"2022-01-25 07:35:48+0000\",\n  \"clientId\" : \"bitzlato\"\n}"
      @secret = '8ccj5ivpwku2u9by27otp969b9x'
      @digest = 'ccfda551ed3ab0dc221952932ddf72050bd7707a'
    end
    it 'ok' do
      webhook = described_class.new(
        params: @params,
        body: @body,
        digest: @digest,
        secret_key: @secret
      )
      expect(webhook.send(:validate_request)).to be_truthy
    end
    it 'fail' do
      @digest = '123456'
      webhook = described_class.new(
        params: @params,
        body: @body,
        digest: @digest,
        secret_key: @secret
      )
      expect { webhook.send(:validate_request) }.to raise_error(SumSub::Webhook::InvalidRequest)
    end
  end
end
