class BarongRecord < ApplicationRecord
  self.abstract_class = true
  connects_to database: { reading: :barong, writing: :barong }

  def readonly?
    true
  end
end
