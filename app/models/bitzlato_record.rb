# frozen_string_literal: true

class BitzlatoRecord < ActiveRecord::Base
  self.abstract_class = true
  establish_connection :bitzlato


  def readonly?
    true
  end
end