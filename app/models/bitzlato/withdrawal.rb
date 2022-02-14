module Bitzlato
  class Withdrawal < Bitzlato::Record
    include Period
    #bitzlato/public/withdrawal
    self.table_name = :withdrawal
    belongs_to :user, class_name: 'Bitzlato::User'
    scope :processed, -> { where status: 'processed' }

  end
end