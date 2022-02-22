module Bitzlato
  class Deposit < Bitzlato::Record
    include Period

    #bitzlato/public/deposit
    self.table_name = :deposit
    belongs_to :user, class_name: 'Bitzlato::User'

    scope :success, -> { where status: 'success' }
  end
end

# == Schema Information
#
# Table name: deposit
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  wallet_id        :integer
#  account          :string(100)
#  fee              :decimal(, )      default(0.0), not null
#  address          :string(68)       not null
#  amount           :decimal(, )      default(0.0), not null
#  blockchain_tx_id :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  comment          :string(256)
#  vout             :integer
#  is_dust          :boolean          default(FALSE), not null
#  cc_code          :string           not null
#  status           :enum             not null
#
