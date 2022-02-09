module PeatioMethods
  extend ActiveSupport::Concern
  included do

    def member
      @member ||= Member.find_by(uid: user_uid)
    end

    def month_income_exchange
      income = Deposit.select('sum(amount) as sum_amount, currency_id')
                      .success
                      .last_1_month
                      .where(member_id: member.id)
                      .group('currency_id')
                      .map { |t| { "#{t.currency_id.upcase}" => t.sum_amount } }
                      .reduce({}, :merge)

      {origin: income, converted: CurrencyConvert.convert(income)}
    end

    def month_outcome_exchange
      outcome = Withdraw.select('sum(amount) as sum_amount, currency_id')
                        .success
                        .last_1_month
                        .where(member_id: member.id)
                        .group('currency_id')
                        .map { |t| { "#{t.currency_id.upcase}" => t.sum_amount } }
                        .reduce({}, :merge)

      {origin: outcome, converted: CurrencyConvert.convert(outcome)}
    end

  end
end