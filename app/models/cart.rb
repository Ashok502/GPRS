class Cart < ApplicationRecord
  has_many :line_items

  def total
  	line_items.to_a.sum{|a| a.full_price}
  end

  def self.monthly_spending
    group_by_month(:date, last: 12, current: false).sum('carts.total')
end
end
