class Cart < ApplicationRecord
  has_many :line_items
  has_one :coupon

  def total
  	cart_total - coupon_p
  end

  def coupon_p
  	self.coupon.present? ? (cart_total*self.coupon.percentage)/100 : 0 
  end

  def cart_total
  	line_items.to_a.sum{|a| a.full_price}
  end

  def self.monthly_spending
    group_by_month(:date, last: 12, current: false).sum('carts.total')
  end
end
