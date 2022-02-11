module Limit
  extend ActiveSupport::Concern
  included do
    def income
      incomes = [p2p_income, month_income_exchange]
      summarize = summarize_hash_limits(incomes)

      {p2p: incomes[0], exchange: incomes[1], summarize: summarize}.with_indifferent_access
    end

    def outcome
      outcomes =[ p2p_outcome, p2p_voucher_withdraw, month_outcome_exchange]
      summarize = summarize_hash_limits(outcomes)
      p2p_summarize = summarize_hash_limits([outcomes[0], outcomes[1]])

      {p2p: p2p_summarize, exchange: outcomes[1], summarize: summarize}.with_indifferent_access
    end

    private

    def summarize_hash_limits(array_of_hash)
      result = {origin: {}, converted: {}}
      array_of_hash.map do |h|
        result[:origin] = result[:origin].merge(h[:origin]){ |k, a_value, b_value| a_value + b_value }
        result[:converted] = result[:converted].merge(h[:converted]){ |k, a_value, b_value| a_value + b_value }
      end
      result
    end
  end
end