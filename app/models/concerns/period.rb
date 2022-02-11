module Period
  extend ActiveSupport::Concern
  included do
    scope :last_24_hours, -> { where('created_at > ?', 24.hour.ago) }
    scope :last_1_month, -> { where('created_at > ?', 1.month.ago) }

    def self.period(type)
      case type
      when :monthly
        self.last_1_month
      when :daily
        self.last_24_hours
      else
        self
      end
    end
  end
end