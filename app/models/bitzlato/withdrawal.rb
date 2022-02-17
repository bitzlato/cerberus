module Bitzlato
  class Withdrawal < Bitzlato::Record
    include Period
    #bitzlato/public/withdrawal
    self.table_name = :withdrawal
    belongs_to :user, class_name: 'Bitzlato::User'
    scope :processed, -> { where status: 'processed' }

  end
end

# == Schema Information
#
# Table name: withdrawal
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  wallet_id        :integer          not null
#  blockchain_tx_id :integer
#  address          :string(68)       not null
#  amount           :decimal(, )      default(0.0), not null
#  fee              :decimal(, )      default(0.0), not null
#  status           :enum             not null
#  created_at       :datetime         not null
#  updated_at       :datetime
#  comment          :text
#  real_pay_fee     :decimal(, )
#  cc_code          :string           not null
#
