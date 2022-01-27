require 'rails_helper'


describe Applicant, type: :model do
  describe 'status' do

    it 'verified' do
      applicant = create(:applicant, :verified)
      expect(applicant.status).to eq('verified')
    end

    it 'banned' do
      applicant = create(:applicant, :banned)
      expect(applicant.status).to eq('banned')
    end

    it 'rejected' do
      applicant = create(:applicant, :rejected)
      expect(applicant.status).to eq('rejected')
    end

    it 'reseted' do
      pending '????'
      expect(applicant.status).to eq('reseted')
    end

  end

  describe 'reset_applicant' do
    before do
      @applicant = create(:applicant, :verified)
    end

    it 'ok' do
      response = {'ok': 1}
      stub_request(:post, "https://test-api.sumsub.com/resources/applicants/#{@applicant.applicant_id}/reset").
        to_return(status: 200, body: response.to_json, headers: {})

      expect(@applicant.reset_applicant).to be_truthy
      @applicant.reload
      expect(@applicant.reseted?).to be_truthy
    end

    it 'fail' do
      response = {'ok': 0}
      stub_request(:post, "https://test-api.sumsub.com/resources/applicants/#{@applicant.applicant_id}/reset").
        to_return(status: 200, body: response.to_json, headers: {})

      expect(@applicant.reset_applicant).to be_falsey
    end
  end
end

# == Schema Information
#
# Table name: applicants
#
#  id                 :bigint           not null, primary key
#  applicant_id       :string           not null
#  inspection_id      :string           not null
#  user_uid           :string           not null
#  source_key         :string
#  start_date         :datetime
#  create_date        :datetime
#  status             :integer
#  review_status      :string
#  moderation_comment :string
#  client_comment     :string
#  review_answer      :string
#  review_reject_type :string
#  webhook_type       :string
#  raw_request        :json
#  fixed_info         :json
#  reject_labels      :json
#
