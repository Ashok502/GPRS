class Coupon < ApplicationRecord
  validates :percentage, presence:  true

  before_create :coupon_number?

  def coupon_number?
    numbers = (0..9).to_a
    pn= 'COUPON' + '-' + numbers[rand(10)].to_s+numbers[rand(10)].to_s+numbers[rand(10)].to_s+numbers[rand(10)].to_s
    self.coupon_code = pn
  end
end
