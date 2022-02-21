# frozen_string_literal: true

class Applicant < ApplicationRecord
  include Period
  include TestWebhook
  include PeatioMethods
  include P2PMethods
  include BarongMethods
  include Limit
  has_paper_trail

  before_create :init_status

  validates :sumsub_applicant_id, uniqueness: true

  enum status: {
    banned: -1,
    rejected: 0,
    verified: 1,
    reseted: 2,
    init: 3
  }

  def email
    barong_user&.email || p2p_user&.real_email
  end

  def sumsub_url
    @sumsub_url ||= SumSub::GenerateUrl.new(public_id: public_id).call
  end

  def public_id
    "cerberus-#{id}-#{Rails.env}"
  end

  # Create Applicant(on sumsub) with reviewStatus: init
  def self.init_applicant(applicant_id)
    applicant = Applicant.find()
    p response = Sumsub::Request.new.create_applicant('basic-kyc-level', {externalUserId: applicant_id, sourceKey: "cerberus-#{Rails.env}"})
    unless response.is_a? Sumsub::Struct::ErrorResponse
      applicant = Applicant.find()
      #TODO: find or create applicant by response['externalUserId']
      #TODO: update fields this applicant from response
      # Applicant.create! sumsub_applicant_id: response['id'],
      #                   create_date: response['createdAt'],
      #                   inspection_id: response['inspectionId'],
      #                   user_uid: response['externalUserId'], #TODO: тут
      #                   review_status: response.dig('review','reviewStatus')
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

  def init_status
    self.status = 'init'
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
