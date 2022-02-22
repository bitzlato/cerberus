module Bitzlato
  class Voucher < Bitzlato::Record
    include Period
    #bitzlato/p2p/voucher
    self.table_name = :voucher
    belongs_to :user, class_name: 'Bitzlato::User'

    scope :not_deleted, -> { where deleted_at: 'NULL' }

    def available?
      cashed_at.nil? && deleted_at.nil?
    end

    def referrer_id
      user_id
    end
  end
end

# == Schema Information
#
# Table name: voucher
#
#  id                     :integer          not null, primary key
#  secret_key             :text             not null
#  cc_code                :string           not null
#  amount                 :decimal(, )      not null
#  currency               :string(3)        not null
#  created_at             :datetime         not null
#  deleted_at             :datetime
#  cashed_at              :datetime
#  user_id                :integer          not null
#  cashed_by_user_id      :integer
#  comment                :text
#  comment_by_cashed_user :text
#
