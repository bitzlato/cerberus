require 'rails_helper'


describe Applicant, type: :model do

  describe 'init_applicant' do
    before do
      stub_create_applicant(public_id: 1111)
    end
    it 'ok' do
      applicant = Applicant.find_or_init_applicant(1111)
      expect(applicant.barong_uid).to eq('1111')
      expect(applicant.status).to eq('init')
    end
  end

  describe 'reset_applicant' do
    before do
      @applicant = create(:applicant, :verified)
    end

    it 'ok' do
      stub_reset(sumsub_applicant_id: @applicant.sumsub_applicant_id, body: { 'ok': 1})

      expect(@applicant.reset_applicant).to be_truthy
    end

    it 'fail' do
      stub_reset(sumsub_applicant_id: @applicant.sumsub_applicant_id, body: { 'ok': 0})

      expect(@applicant.reset_applicant).to be_falsey
    end
  end
end

# == Schema Information
#
# Table name: applicants
#
#  id                  :bigint           not null, primary key
#  sumsub_applicant_id :string           not null
#  inspection_id       :string           not null
#  barong_uid          :string           not null
#  bitzlato_id         :string
#  uid                 :string
#
