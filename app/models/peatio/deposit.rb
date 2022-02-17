# frozen_string_literal: true

module Peatio
  class Deposit < Peatio::Record
    include Period
    COMPLETED_STATES = %i[dispatched].freeze
    TRANSFER_TYPES = { fiat: 100, crypto: 200 }.freeze

    self.inheritance_column = :fake_type

    belongs_to :peatio_member, required: true

    scope :success, -> { completed }
    scope :skipped, -> { where aasm_state: %i[skipped] }
    scope :accountable, -> { where aasm_state: %i[dispatched skipped] }
    scope :completed, -> { where aasm_state: COMPLETED_STATES }
    scope :uncompleted, -> { where.not(aasm_state: COMPLETED_STATES) }
    scope :locked, -> { where(is_locked: true) }

    scope :recent, -> { order(id: :desc) }

    delegate :uid, to: :peatio_member, prefix: true

    def to_s
      ['deposit#', id.to_s, ' ', amount.to_s, ' ', currency_id].join
    end

    def transaction_url
      return if txid.nil?

      blockchain&.explore_transaction_url txid
    end

    def recorded_transaction
      blockchain.transactions.find_by(txid: txid, txout: txout)
    end

    def account
      member&.get_account(currency)
    end

    def completed?
      aasm_state.in?(COMPLETED_STATES.map(&:to_s))
    end

    def self.ransackable_scopes(auth_object = nil)
      %i[uncompleted completed] + super
    end
  end
end

# == Schema Information
#
# Table name: deposits
#
#  id                 :bigint           not null, primary key
#  member_id          :bigint           not null
#  currency_id        :string(20)       not null
#  amount             :decimal(36, 18)  not null
#  fee                :decimal(36, 18)  not null
#  txid               :citext
#  aasm_state         :string(30)       not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  completed_at       :datetime
#  type               :string(30)       not null
#  txout              :integer
#  tid                :citext           not null
#  address            :string(95)
#  block_number       :integer
#  from_addresses     :text
#  transfer_type      :integer
#  data               :json
#  invoice_id         :string
#  error              :json
#  blockchain_id      :bigint           not null
#  invoice_expires_at :datetime
#  is_locked          :boolean          default(FALSE), not null
#
