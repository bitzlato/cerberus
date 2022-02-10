module P2PMethods
  extend ActiveSupport::Concern
  included do

    def p2p_user
      @p2p_user ||= BitzlatoUser.find(user_uid)
    end

    def p2p_voucher_withdraw
      #TODO: непонятно это вводы или вывод
      amount = BitzlatoWithdrawVoucher.joins(:voucher)
                                      .last_1_month
                                      .where(user: p2p_user)
                                      .select('sum(voucher.amount) as sum_amount, voucher.cc_code as currency_id')
                                      .group(:currency_id)
                                      .map { |t| { "#{t.currency_id.upcase}" => t.sum_amount } }
                                      .reduce({}, :merge)

      {origin: amount, converted: CurrencyConvert.convert(amount)}
    end

    def p2p_income
      income = BitzlatoDeposit.success
                              .last_1_month
                              .where(user: p2p_user)
                              .select('sum(fee) + sum(amount) as sum_amount , cc_code as currency_id')
                              .group('currency_id')
                              .map { |t| { "#{t.currency_id.upcase}" => t.sum_amount } }
                              .reduce({}, :merge)

      {origin: income, converted: CurrencyConvert.convert(income)}
    end


    def p2p_outcome
      outcome = BitzlatoWithdrawal.processed
                                  .last_1_month
                                  .where(user: p2p_user)
                                  .select('sum(amount) as sum_amount, cc_code as currency_id')
                                  .group('currency_id')
                                  .map { |t| { "#{t.currency_id.upcase}" => t.sum_amount } }
                                  .reduce({}, :merge)


      {origin: outcome, converted: CurrencyConvert.convert(outcome)}
    end

  end
end