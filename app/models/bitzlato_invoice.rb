
class BitzlatoInvoice < BitzlatoRecord
  DEEPLINK_PREFIX = 'b_'
  DEEPLINK_TYPE = 'bill'

  self.table_name = :invoice
  self.inheritance_column = nil

  belongs_to :merchant, class_name: 'BitzlatoMerchant'

  TYPES = %w[open close].freeze
  enum type: TYPES.each_with_object({}) { |e,a| a[e] = e }

  STATUSES = %w[active pause].freeze
  enum status: STATUSES.each_with_object({}) { |e,a| a[e] = e }

  def self.find_by_deeplink_code(code)
    find_by(secret_key: code)
  end

  def deep_link_code
    DEEPLINK_PREFIX + secret_key
  end

  def deep_link_type
    DEEPLINK_TYPE
  end

  def available?
    active? && deleted_at.nil? && completed_at.nil? && (expiry_at.present? && expiry_at < DateTime.current)
  end

  def referrer_id
    merchant.user.id
  end
end