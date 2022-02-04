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

    it 'init' do
      applicant = create(:applicant, :init)
      expect(applicant.status).to eq('init')
    end
  end

  describe 'init_applicant' do
    before do
      stub_create_applicant(user_id: 1111)
    end
    it 'ok' do
      applicant = Applicant.init_applicant(1111)
      expect(applicant.user_uid).to eq('1111')
      expect(applicant.status).to eq('init')
    end
  end

  describe 'reset_applicant' do
    before do
      @applicant = create(:applicant, :verified)
    end

    it 'ok' do
      stub_reset(applicant_id: @applicant.applicant_id, body: {'ok': 1})

      expect(@applicant.reset_applicant).to be_truthy
    end

    it 'fail' do
      stub_reset(applicant_id: @applicant.applicant_id, body: {'ok': 0})

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
