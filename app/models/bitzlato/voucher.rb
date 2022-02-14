module Bitzlato
  class Voucher < Bitzlato::Record
    #bitzlato/p2p/voucher
    self.table_name = :voucher
    belongs_to :user, class_name: 'Bitzlato::User'

    def available?
      cashed_at.nil? && deleted_at.nil?
    end

    def referrer_id
      user_id
    end
  end
end