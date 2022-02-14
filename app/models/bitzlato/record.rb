# frozen_string_literal: true

class Bitzlato::Record < ActiveRecord::Base
  self.abstract_class = true
  establish_connection :bitzlato


  def readonly?
    true
  end
end