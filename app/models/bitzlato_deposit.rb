class BitzlatoDeposit < BitzlatoRecord
  include Period

  #bitzlato/public/deposit
  self.table_name = :deposit
  belongs_to :user, class_name: 'BitzlatoUser'

  scope :success, -> { where status: 'success' }
end