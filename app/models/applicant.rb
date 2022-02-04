# frozen_string_literal: true

class Applicant < ApplicationRecord
  include TestWebhook
  has_paper_trail

  validates :applicant_id, :user_uid, presence: true
  validates :applicant_id, uniqueness: true

  enum status: {
    banned: -1,
    rejected: 0,
    verified: 1,
    reseted: 2
  }

  before_save do
    self.status = 'verified' if review_answer == 'GREEN'
    self.status = 'banned'   if review_answer == 'RED' && review_reject_type == 'FINAL'
    self.status = 'rejected' if review_answer == 'RED' && review_reject_type == 'RETRY'
  end

  # Create Applicant(on sumsub) with reviewStatus: init
  def self.init_applicant(external_user_id)
    Sumsub::Request.new.create_applicant('basic-kyc-level', {externalUserId: external_user_id})
  end

  def reset_applicant
    response = Sumsub::Request.new.reset_applicant(applicant_id)
    if response['ok'] == 1
      true
    else
      false
    end
  rescue Dry::Struct::MissingAttributeError
    false
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
