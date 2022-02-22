module P2PMethods
  extend ActiveSupport::Concern
  included do

    def p2p_user
      @p2p_user ||= Bitzlato::User.find_by_id(bitzlato_id)
    end

    def p2p_voucher_outcome(period: :monthly)
      amount = Bitzlato::Voucher.where('voucher.cashed_by_user_id is NULL and user_id = ?', p2p_user&.id)
                                .period(period)
                                .not_deleted
                                .select('sum(amount) as sum_amount, cc_code as currency_id')
                                .group(:currency_id)
                                .map { |t| { "#{t.currency_id.upcase}" => t.sum_amount } }
                                .reduce({}, :merge)


      {origin: amount, converted: CurrencyConvert.convert(amount)}
    end

    def p2p_voucher_income(period: :monthly)
      amount = Bitzlato::Voucher.where('voucher.cashed_by_user_id = ?', p2p_user&.id)
                                .period(period)
                                .not_deleted
                                .select('sum(amount) as sum_amount, cc_code as currency_id')
                                .group(:currency_id)
                                .map { |t| { "#{t.currency_id.upcase}" => t.sum_amount } }
                                .reduce({}, :merge)

      {origin: amount, converted: CurrencyConvert.convert(amount)}
    end


    def p2p_income(period: :monthly)
      income = Bitzlato::Deposit.success
                                .period(period)
                                .where(user: p2p_user)
                                .select('sum(fee) + sum(amount) as sum_amount , cc_code as currency_id')
                                .group('currency_id')
                                .map { |t| { "#{t.currency_id.upcase}" => t.sum_amount } }
                                .reduce({}, :merge)

      {origin: income, converted: CurrencyConvert.convert(income)}
    rescue StandardError => e
      p e
      {origin: {}, converted: {}}
    end


    def p2p_outcome(period: :monthly)
      outcome = Bitzlato::Withdrawal.processed
                                    .period(period)
                                    .where(user: p2p_user)
                                    .select('sum(amount) as sum_amount, cc_code as currency_id')
                                    .group('currency_id')
                                    .map { |t| { "#{t.currency_id.upcase}" => t.sum_amount } }
                                    .reduce({}, :merge)


      {origin: outcome, converted: CurrencyConvert.convert(outcome)}
    rescue StandardError => e
      p e
      {origin: {}, converted: {}}
    end

    private

    def p2p_period

    end

  end
end