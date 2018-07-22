class CreateLineItems < ActiveRecord::Migration[5.2]
  def change
    create_table :line_items do |t|
      t.references :cart
      t.references :product
      t.decimal :unit_price
      t.integer :quantity
      t.timestamps
    end
  end
end
