# frozen_string_literal: true

class Applicant < ApplicationRecord
  validates :applicant_id, :user_uid, presence: true
end

# == Schema Information
#
# Table name: applicants
#
#  id                 :bigint           not null, primary key
#  applicant_id       :string           not null
#  user_uid           :string           not null
#  source_key         :string
#  start_date         :datetime
#  create_date        :datetime
#  review_status      :string
#  fixed_info         :json
#  reject_labels      :json
#  moderation_comment :string
#  client_comment     :string
#  review_answer      :string
#  review_reject_type :string
#
