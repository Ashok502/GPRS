class AddProjectIdToCoupon < ActiveRecord::Migration[5.2]
  def change
  	add_column :coupons, :product_id, :integer, default: nil
  end
end
