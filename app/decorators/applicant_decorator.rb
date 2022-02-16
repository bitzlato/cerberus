class ApplicantDecorator < Draper::Decorator
  delegate_all


  def status_colored
    class_name = ''
    case object.status
    when 'verified'
      class_name = 'badge badge-success'
    when 'banned'
      class_name = 'badge badge-danger'
    when 'rejected'
      class_name = 'badge badge-warning'
    when 'init'
      class_name = 'badge badge-info'
    when 'reseted'
      class_name = 'badge badge-muted'
    end
    h.content_tag(:span, object.status, class: class_name)
  end

  ######

  def usd_income
    "#{income_lazy.dig(:summarize, :converted, 'USDC').round(2) rescue 0} $"
  end

  def usd_exchange_income
    "#{income_lazy.dig(:exchange, :converted, 'USDC').round(2) rescue 0} $"
  end

  def usd_p2p_income
    "#{income_lazy.dig(:p2p, :converted, 'USDC').round(2) rescue 0} $"
  end

  #####################################

  def usd_outcome
    "#{outcome_lazy.dig(:summarize, :converted, 'USDC').round(2) rescue 0} $"
  end

  def usd_exchange_outcome
    "#{outcome_lazy.dig(:exchange, :converted, 'USDC').round(2) rescue 0} $"
  end

  def usd_p2p_outcome
    "#{outcome_lazy.dig(:p2p, :converted, 'USDC').round(2) rescue 0} $"
  end

  #####################################
  #####################################

  def btc_outcome
    "#{outcome_lazy.dig(:summarize, :converted, 'BTC').round(4) rescue 0} ₿"
  end

  def btc_exchange_outcome
    "#{outcome_lazy.dig(:exchange, :converted, 'BTC').round(4) rescue 0} ₿"
  end

  def btc_p2p_outcome
    "#{outcome_lazy.dig(:p2p, :converted, 'BTC').round(4) rescue 0} ₿"
  end

  #####################################

  def btc_income
    "#{income_lazy.dig(:summarize, :converted, 'BTC').round(4) rescue 0} ₿"
  end

  def btc_exchange_income
    "#{income_lazy.dig(:exchange, :converted, 'BTC').round(4) rescue 0} ₿"
  end

  def btc_p2p_income
    "#{income_lazy.dig(:p2p, :converted, 'BTC').round(4) rescue 0} ₿"
  end

  #####################################
  #####################################

  def outcome_detailed
    outcome = outcome_lazy
    "Exchange: (#{usd_exchange_outcome}, #{btc_exchange_outcome})\n
     p2p: (#{usd_p2p_outcome}, #{btc_p2p_outcome})\n
     sum: (#{usd_outcome}, #{btc_outcome})\n
    "
  end

  def income_detailed
    outcome = outcome_lazy
    "Exchange: (#{usd_exchange_income}, #{btc_exchange_income})\n
     p2p: (#{usd_p2p_income}, #{btc_p2p_income})\n
     sum: (#{usd_income}, #{btc_income})\n
    "
  end

  private

  def income_lazy
    @income_lazy ||= object.income
  end

  def outcome_lazy
    @outcome_lazy ||= object.outcome
  end

end
