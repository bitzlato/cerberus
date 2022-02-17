# frozen_string_literal: true

class Applicant < ApplicationRecord
  include Period
  include TestWebhook
  include PeatioMethods
  include P2PMethods
  include BarongMethods
  include Limit
  has_paper_trail

  before_validation :assign_uid

  validates :uid, presence: true
  validates :sumsub_applicant_id, uniqueness: true
  validates :uid, uniqueness:  true

  enum status: {
    banned: -1,
    rejected: 0,
    verified: 1,
    reseted: 2,
    init: 3
  }

  before_save do
    self.status = 'verified' if review_answer == 'GREEN'
    self.status = 'banned'   if review_answer == 'RED' && review_reject_type == 'FINAL'
    self.status = 'rejected' if review_answer == 'RED' && review_reject_type == 'RETRY'
    self.status = 'init' if review_status == 'init'
    self.status = 'reseted' if webhook_type == 'applicantReset'
  end

  def email
    barong_user&.email || p2p_user&.real_email
  end

  def sumsub_url
    @sumsub_url ||= SumSub::GenerateUrl.new(applicant_id: uid).call
  end


  # Create Applicant(on sumsub) with reviewStatus: init
  def self.init_applicant(applicant_id)
    applicant = Applicant.find()
    p response = Sumsub::Request.new.create_applicant('basic-kyc-level', {externalUserId: applicant_id, sourceKey: "kyc-service-#{Rails.env}"})
    unless response.is_a? Sumsub::Struct::ErrorResponse
      applicant = Applicant.find()
      #TODO: find or create applicant by response['externalUserId']
      #TODO: update fields this applicant from response
      Applicant.create! sumsub_applicant_id: response['id'],
                        create_date: response['createdAt'],
                        inspection_id: response['inspectionId'],
                        user_uid: response['externalUserId'], #TODO: тут
                        review_status: response.dig('review','reviewStatus')
    end
  end

  def reset_applicant
    raise "Unknown sumsub_applicant_id in Applicant##{uid}" if self.sumsub_applicant_id.nil?
    response = Sumsub::Request.new.reset_applicant(sumsub_applicant_id)
    if response['ok'] == 1
      true
    else
      false
    end
  rescue Dry::Struct::MissingAttributeError
    false
  end

  private

  def assign_uid
    return unless uid.blank?
    self.uid = UidGenerator.generate
  end
end

# == Schema Information
#
# Table name: applicants
#
#  id                  :bigint           not null, primary key
#  uid                 :string
#  sumsub_applicant_id :string
#  inspection_id       :string
#  barong_uid          :string
#  bitzlato_id         :string
#  source_key          :string
#  start_date          :datetime
#  create_date         :datetime
#  status              :integer
#  review_status       :string
#  moderation_comment  :string
#  client_comment      :string
#  review_answer       :string
#  review_reject_type  :string
#  webhook_type        :string
#  raw_request         :json
#  fixed_info          :json
#  reject_labels       :json
#
