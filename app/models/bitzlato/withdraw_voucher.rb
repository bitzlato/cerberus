module Bitzlato
  class WithdrawVoucher < Bitzlato::Record
    include Period

    self.table_name = :withdraw_voucher

    belongs_to :user, class_name: 'Bitzlato::User'

    belongs_to :voucher, class_name: 'Bitzlato::Voucher', primary_key: :id, foreign_key: :payment_id


    scope :last_24_hours, -> { where('used_at > ?', 24.hour.ago) }
    scope :last_1_month, -> { where('used_at > ?', 1.month.ago) }


    def available?
      (expire_at.present? && expire_at < DateTime.current) && used_at.nil?
    end
  end
end

# == Schema Information
#
# Table name: withdraw_voucher
#
#  id                       :integer          not null, primary key
#  user_id                  :integer
#  payment_id               :integer
#  created_at               :datetime         not null
#  used_at                  :datetime
#  secret_key               :text             not null
#  expire_at                :datetime         not null
#  first_notification_sent  :boolean          default(FALSE), not null
#  second_notification_sent :boolean          default(FALSE), not null
#  prime_time_event_name    :string(64)
#
