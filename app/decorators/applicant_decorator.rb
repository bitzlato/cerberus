class ApplicantDecorator < Draper::Decorator
  delegate_all

  def self.collection_decorator_class
    PaginatingDecorator
  end

  CSS_STATUS_CLASSES = { 'reseted' => 'badge badge-muted',
                         'rejected' => 'badge badge-warning',
                         'verified' => 'badge badge-success',
                         'banned' => 'badge badge-danger',
                         'init' => 'badge badge-info', }

  CURRENCY_SUMBOLS = { 'usdc': '$',
                       'btc': '₿' }.with_indifferent_access


  def status_colored
    h.content_tag(:span, object.status, class: CSS_STATUS_CLASSES[object.status])
  end


  ['monthly', 'daily'].each do |period|
    ['usdc', 'btc'].each do |currency|
      ['income','outcome'].each do |direction|
        ['p2p', 'exchange', 'summarize', 'voucher'].each do |from|

          define_method "#{period}_#{currency}_#{from}_#{direction}" do
            lazy = self.send("#{direction}_#{period}_lazy")
            "#{lazy.dig(from.to_sym, :converted, currency.upcase).round(2)} #{CURRENCY_SUMBOLS[currency]}"
          rescue
            '-'
          end
        end
      end
    end
  end

  private

  def income_monthly_lazy
    @income_monthly_lazy ||= object.income(period: :monthly)
  end

  def outcome_monthly_lazy
    @outcome_monthly_lazy ||= object.outcome(period: :monthly)
  end

  def income_daily_lazy
    @income_daily_lazy ||= object.income(period: :daily)
  end

  def outcome_daily_lazy
    @outcome_daily_lazy ||= object.outcome(period: :daily)
  end

end
