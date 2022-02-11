module Limit
  extend ActiveSupport::Concern
  included do

    def income
      result = {origin: {}, converted: {}}
      incomes = []

      incomes << p2p_income
      incomes << p2p_voucher_withdraw
      incomes << month_income_exchange
      incomes.map do |h|
        result[:origin] = result[:origin].merge(h[:origin]){ |k, a_value, b_value| a_value + b_value }
        result[:converted] = result[:converted].merge(h[:converted]){ |k, a_value, b_value| a_value + b_value }
      end

      result.with_indifferent_access
    end

    def outcome
      result = {origin: {}, converted: {}}
      outcomes = []

      outcomes << p2p_outcome
      outcomes << month_outcome_exchange
      outcomes.map do |h|
        result[:origin] = result[:origin].merge(h[:origin]){ |k, a_value, b_value| a_value + b_value }
        result[:converted] = result[:converted].merge(h[:converted]){ |k, a_value, b_value| a_value + b_value }
      end

      result.with_indifferent_access
    end

  end
end