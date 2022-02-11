class BitzlatoWithdrawal < BitzlatoRecord
  include Period

  #bitzlato/public/withdrawal
  self.table_name = :withdrawal
  belongs_to :user, class_name: 'BitzlatoUser'

  scope :processed, -> { where status: 'processed' }




end