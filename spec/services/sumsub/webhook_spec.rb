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
    end
    it 'ok' do
      webhook = described_class.new(
        params: @params,
        validate_request: false
      )
      webhook.call
      applicant = Applicant.last
      expect(applicant.applicant_id).to eq @params['applicantId']
      expect(applicant.inspection_id).to eq @params['inspectionId']
      expect(applicant.user_uid).to eq @params['externalUserId']
      expect(applicant.source_key).to eq @params['sourceKey']
      expect(applicant.create_date).to eq @params['createdAt']
      expect(applicant.reject_labels).to eq @params['reviewResult']['rejectLabels']
      expect(applicant.moderation_comment).to eq @params['reviewResult']['moderationComment']
      expect(applicant.review_answer).to eq @params['reviewResult']['reviewAnswer']
      expect(applicant.review_status).to eq @params['reviewResult']['reviewStatus']
      expect(applicant.review_reject_type).to eq @params['reviewResult']['reviewRejectType']
      expect(applicant.raw_request).to eq @params
      expect(applicant.status).to eq 'rejected'
    end
  end

  describe 'change applicant' do
    before do
      @applicant = create(:applicant, :rejected)
      @params = {
        'applicantId': @applicant.applicant_id,
        'inspectionId': @applicant.inspection_id,
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
    end

    it 'ok' do
      webhook = described_class.new(
        params: @params,
        validate_request: false
      )
      webhook.call
      expect(@applicant.status).to eq('rejected')
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
