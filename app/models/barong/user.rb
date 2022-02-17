module Barong
  class User < Barong::Record
    self.table_name = :users
  end
end

# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  uid              :string           not null
#  email            :string           not null
#  password_digest  :string           not null
#  role             :string           default("member"), not null
#  level            :integer          default(0), not null
#  otp              :boolean          default(FALSE)
#  state            :string           default("pending"), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  referral_id      :bigint
#  data             :text
#  username         :string
#  api_keys_limit   :integer          default(1), not null
#  rate_limit_level :integer          default(1), not null
#
