module Bitzlato
  class Deposit < Bitzlato::Record
    include Period

    #bitzlato/public/deposit
    self.table_name = :deposit
    belongs_to :user, class_name: 'Bitzlato::User'

    scope :success, -> { where status: 'success' }
  end
end