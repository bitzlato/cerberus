# frozen_string_literal: true
# Copyright (c) 2019 Danil Pismenny <danil@brandymint.ru>

module Peatio
  class Member < Peatio::Record
    BOT_UIDS = ENV.fetch('STATS_EXCLUDE_MEMBER_UIDS', []).split(',')

    has_many :orders
    has_many :accounts
    # has_many :stats_member_pnl
    has_many :payment_addresses
    has_many :withdraws, -> { order(id: :desc) }
    has_many :deposits, -> { order(id: :desc) }
    has_many :beneficiaries, -> { order(id: :desc) }
    has_many :operations_revenues, class_name: 'Operations::Revenue'
    has_many :operations_liabilities, class_name: 'Operations::Liability'

    scope :enabled, -> { where(state: 'active') }

    def trades
      Trade.by_member(id)
    end

    def self.bots
      Member.where(uid: BOT_UIDS)
    end

    def to_s
      uid
    end

    def title
      email
    end

    def get_account(model_or_id_or_code)
      case model_or_id_or_code
      when String, Symbol
        accounts.find_by(currency_id: model_or_id_or_code)
      when Currency
        accounts.find_by(currency: model_or_id_or_code)
      else
        raise "Unknown type #{model_or_id_or_code}"
      end
    end

    def balance_for(currency:, kind:)
      account_code = Operations::Account.find_by(
        type: :liability,
        kind: kind,
        currency_type: currency.type
      ).code
      liabilities = Operations::Liability.where(member_id: id, currency: currency, code: account_code)
      liabilities.sum('credit - debit')
    end
  end
end

# == Schema Information
#
# Table name: members
#
#  id                        :bigint           not null, primary key
#  email                     :string
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  uid                       :string(32)       not null
#  level                     :integer          not null
#  role                      :string(16)       not null
#  state                     :string(16)       not null
#  group                     :string(32)       default("any"), not null
#  username                  :string
#  withdraw_disabled_at      :datetime
#  withdraw_disabled_comment :string
#  withdraw_disabled_by      :integer
#
