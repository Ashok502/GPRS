class CreateCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :coupons do |t|
      t.string :coupon_code
      t.decimal :percentage
      t.references :cart
      t.string :status, default: 'New'
      t.timestamps
    end
  end
end
