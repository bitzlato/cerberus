module PeatioMethods
  extend ActiveSupport::Concern
  included do

    def peatio_member
      @member ||= Peatio::Member.find_by(uid: user_uid)
    end

    def exchange_income(period: :monthly)
      income = Peatio::Deposit.select('sum(amount) as sum_amount, currency_id')
                              .success
                              .period(period)
                              .where(member_id: peatio_member.id)
                              .group('currency_id')
                              .map { |t| { "#{t.currency_id.upcase}" => t.sum_amount } }
                              .reduce({}, :merge)

      {origin: income, converted: CurrencyConvert.convert(income)}
    rescue StandardError => e
      p e
      {origin: {}, converted: {}}
    end

    def exchange_outcome(period: :monthly)
      outcome = Peatio::Withdraw.select('sum(amount) as sum_amount, currency_id')
                                .success
                                .period(period)
                                .where(member_id: peatio_member.id)
                                .group('currency_id')
                                .map { |t| { "#{t.currency_id.upcase}" => t.sum_amount } }
                                .reduce({}, :merge)

      {origin: outcome, converted: CurrencyConvert.convert(outcome)}
    rescue StandardError => e
      p e
      {origin: {}, converted: {}}
    end

  end
end