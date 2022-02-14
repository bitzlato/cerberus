# frozen_string_literal: true

module Bitzlato
  class Bitzlato::Profile < Bitzlato::Record
    self.table_name = :user_profile
    belongs_to :bitzlato_user, class_name: 'Bitzlato::User', foreign_key: :user_id
  end
end