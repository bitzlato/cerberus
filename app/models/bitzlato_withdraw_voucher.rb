class BitzlatoWithdrawVoucher < BitzlatoRecord
  DEEPLINK_PREFIX = 'w_'
  DEEPLINK_TYPE = :withdraw_voucher
  self.table_name = :withdraw_voucher

  belongs_to :user, class_name: 'BitzlatoUser'

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
    (expire_at.present? && expire_at < DateTime.current) && used_at.nil?
  end

  def referrer_id
    user_id
  end
end