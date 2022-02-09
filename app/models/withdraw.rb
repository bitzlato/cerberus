# Copyright (c) 2019 Danil Pismenny <danil@brandymint.ru>

# frozen_string_literal: true

class Withdraw < PeatioRecord
  self.inheritance_column = nil
  STATES = %i[prepared rejected accepted skipped processing succeed canceled failed errored confirming].freeze
  COMPLETED_STATES = %i[succeed rejected canceled failed].freeze
  SUCCEED_PROCESSING_STATES = %i[prepared accepted skipped processing errored confirming succeed].freeze
  SUCCESS_STATES = %i[succeed].freeze

  scope :success, -> { where aasm_state: SUCCESS_STATES }
  scope :completed, -> { where(aasm_state: COMPLETED_STATES) }
  scope :uncompleted, -> { where.not(aasm_state: COMPLETED_STATES) }
  scope :succeed_processing, -> { where(aasm_state: SUCCEED_PROCESSING_STATES) }
  scope :last_24_hours, -> { where('created_at > ?', 24.hour.ago) }
  scope :last_1_month, -> { where('created_at > ?', 1.month.ago) }
  scope :locked, -> { where(is_locked: true) }
end
