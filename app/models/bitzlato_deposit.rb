class BitzlatoDeposit < BitzlatoRecord
  #bitzlato/public/deposit
  self.table_name = :deposit
  belongs_to :user, class_name: 'BitzlatoUser'

  scope :last_24_hours, -> { where('created_at > ?', 24.hour.ago) }
  scope :last_1_month, -> { where('created_at > ?', 1.month.ago) }
  scope :success, -> { where status: 'success' }
end