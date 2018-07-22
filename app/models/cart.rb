class Cart < ApplicationRecord
  has_many :line_items

  def total
  	line_items.to_a.sum{|a| a.full_price}
  end
end
