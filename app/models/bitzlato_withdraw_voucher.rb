class BitzlatoWithdrawVoucher < BitzlatoRecord
  include Period

  self.table_name = :withdraw_voucher

  belongs_to :user, class_name: 'BitzlatoUser'

  belongs_to :voucher, class_name: 'BitzlatoVoucher', primary_key: :id, foreign_key: :payment_id


  scope :last_24_hours, -> { where('used_at > ?', 24.hour.ago) }
  scope :last_1_month, -> { where('used_at > ?', 1.month.ago) }


  def available?
    (expire_at.present? && expire_at < DateTime.current) && used_at.nil?
  end
end