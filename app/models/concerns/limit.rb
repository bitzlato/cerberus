module Limit
  extend ActiveSupport::Concern
  included do
    def income(period: :monthly)
      incomes = []
      incomes << p2p_income(period: period)
      incomes << exchange_income(period: period)
      incomes << p2p_voucher_income(period: period)

      summarize = summarize_hash_limits(incomes)

      {p2p: incomes[0], exchange: incomes[1], voucher: incomes[2], summarize: summarize}.with_indifferent_access
    end

    def outcome(period: :monthly)
      outcomes = []
      outcomes << p2p_outcome(period: period)
      outcomes << exchange_outcome(period: period)
      outcomes << p2p_voucher_outcome(period: period)

      summarize = summarize_hash_limits(outcomes)

      {p2p: outcomes[0], exchange: outcomes[1], voucher: outcomes[2], summarize: summarize}.with_indifferent_access
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