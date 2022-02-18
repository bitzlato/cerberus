class ApplicantDecorator < Draper::Decorator
  delegate_all


  CSS_CLASSES = { 'reseted' => 'badge badge-muted',
                  'rejected' => 'badge badge-warning',
                  'verified' => 'badge badge-success',
                  'banned' => 'badge badge-danger',
                  'init' => 'badge badge-info',
  }


  def status_colored
    h.content_tag(:span, object.status, class: CSS_CLASSES[object.status])
  end

  ######

  def monthly_usd_income
    "#{income_monthly_lazy.dig(:summarize, :converted, 'USDC').round(2) rescue 0} $"
  end

  def monthly_usd_exchange_income
    "#{income_monthly_lazy.dig(:exchange, :converted, 'USDC').round(2) rescue 0} $"
  end

  def monthly_usd_p2p_income
    "#{income_monthly_lazy.dig(:p2p, :converted, 'USDC').round(2) rescue 0} $"
  end

  def daily_usd_income
    "#{income_daily_lazy.dig(:summarize, :converted, 'USDC').round(2) rescue 0} $"
  end

  def daily_usd_exchange_income
    "#{income_daily_lazy.dig(:exchange, :converted, 'USDC').round(2) rescue 0} $"
  end

  def daily_usd_p2p_income
    "#{income_daily_lazy.dig(:p2p, :converted, 'USDC').round(2) rescue 0} $"
  end


  #####################################

  def monthly_usd_outcome
    "#{outcome_monthly_lazy.dig(:summarize, :converted, 'USDC').round(2) rescue 0} $"
  end

  def monthly_usd_exchange_outcome
    "#{outcome_monthly_lazy.dig(:exchange, :converted, 'USDC').round(2) rescue 0} $"
  end

  def monthly_usd_p2p_outcome
    "#{outcome_monthly_lazy.dig(:p2p, :converted, 'USDC').round(2) rescue 0} $"
  end

  def daily_usd_outcome
    "#{outcome_daily_lazy.dig(:summarize, :converted, 'USDC').round(2) rescue 0} $"
  end

  def daily_usd_exchange_outcome
    "#{outcome_daily_lazy.dig(:exchange, :converted, 'USDC').round(2) rescue 0} $"
  end

  def daily_usd_p2p_outcome
    "#{outcome_daily_lazy.dig(:p2p, :converted, 'USDC').round(2) rescue 0} $"
  end

  #####################################
  #####################################

  def monthly_btc_outcome
    "#{outcome_monthly_lazy.dig(:summarize, :converted, 'BTC').round(4) rescue 0} ₿"
  end

  def monthly_btc_exchange_outcome
    "#{outcome_monthly_lazy.dig(:exchange, :converted, 'BTC').round(4) rescue 0} ₿"
  end

  def monthly_btc_p2p_outcome
    "#{outcome_monthly_lazy.dig(:p2p, :converted, 'BTC').round(4) rescue 0} ₿"
  end

  def daily_btc_outcome
    "#{outcome_daily_lazy.dig(:summarize, :converted, 'BTC').round(4) rescue 0} ₿"
  end

  def daily_btc_exchange_outcome
    "#{outcome_daily_lazy.dig(:exchange, :converted, 'BTC').round(4) rescue 0} ₿"
  end

  def daily_btc_p2p_outcome
    "#{outcome_daily_lazy.dig(:p2p, :converted, 'BTC').round(4) rescue 0} ₿"
  end


  #####################################

  def monthly_btc_income
    "#{income_monthly_lazy.dig(:summarize, :converted, 'BTC').round(4) rescue 0} ₿"
  end

  def monthly_btc_exchange_income
    "#{income_monthly_lazy.dig(:exchange, :converted, 'BTC').round(4) rescue 0} ₿"
  end

  def monthly_btc_p2p_income
    "#{income_monthly_lazy.dig(:p2p, :converted, 'BTC').round(4) rescue 0} ₿"
  end


  def daily_btc_income
    "#{income_daily_lazy.dig(:summarize, :converted, 'BTC').round(4) rescue 0} ₿"
  end

  def daily_btc_exchange_income
    "#{income_daily_lazy.dig(:exchange, :converted, 'BTC').round(4) rescue 0} ₿"
  end

  def daily_btc_p2p_income
    "#{income_daily_lazy.dig(:p2p, :converted, 'BTC').round(4) rescue 0} ₿"
  end

  #####################################
  #####################################


  private

  def income_monthly_lazy
    @income_lazy ||= object.income(period: :monthly)
  end

  def outcome_monthly_lazy
    @outcome_lazy ||= object.outcome(period: :monthly)
  end

  def income_monthly_daily
    @income_lazy ||= object.income(period: :daily)
  end

  def outcome_monthly_daily
    @outcome_lazy ||= object.outcome(period: :daily)
  end

end
