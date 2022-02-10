class BitzlatoWithdraw < BitzlatoRecord
  self.table_name = :voucher
  belongs_to :user, class_name: 'BitzlatoUser'

  def available?
    cashed_at.nil? && deleted_at.nil?
  end

  def referrer_id
    user_id
  end
end