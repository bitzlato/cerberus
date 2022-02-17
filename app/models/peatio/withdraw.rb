# frozen_string_literal: true
# Copyright (c) 2019 Danil Pismenny <danil@brandymint.ru>

module Peatio
  class Withdraw < Peatio::Record
    include Period
    self.inheritance_column = nil
    STATES = %i[prepared rejected accepted skipped processing succeed canceled failed errored confirming].freeze
    COMPLETED_STATES = %i[succeed rejected canceled failed].freeze
    SUCCEED_PROCESSING_STATES = %i[prepared accepted skipped processing errored confirming succeed].freeze
    SUCCESS_STATES = %i[succeed].freeze

    scope :success, -> { where aasm_state: SUCCESS_STATES }
    scope :completed, -> { where(aasm_state: COMPLETED_STATES) }
    scope :uncompleted, -> { where.not(aasm_state: COMPLETED_STATES) }
    scope :succeed_processing, -> { where(aasm_state: SUCCEED_PROCESSING_STATES) }
    scope :locked, -> { where(is_locked: true) }
  end

end

# == Schema Information
#
# Table name: withdraws
#
#  id             :bigint           not null, primary key
#  member_id      :bigint           not null
#  currency_id    :string(20)       not null
#  amount         :decimal(36, 18)  not null
#  fee            :decimal(36, 18)  not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  completed_at   :datetime
#  txid           :citext
#  aasm_state     :string(30)       not null
#  sum            :decimal(36, 18)  not null
#  type           :string(30)       not null
#  tid            :citext           not null
#  rid            :string(256)      not null
#  block_number   :integer
#  note           :string(256)
#  error          :json
#  beneficiary_id :bigint
#  transfer_type  :integer
#  metadata       :json
#  remote_id      :string
#  blockchain_id  :bigint           not null
#  tx_dump        :jsonb
#  is_locked      :boolean          default(FALSE), not null
#
