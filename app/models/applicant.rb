# frozen_string_literal: true

# Model for KYC process information
class Applicant < ApplicationRecord
  belongs_to :user
  validates :applicant_id, :user_id, presence: true
end