class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.references :user
      t.references :category
      t.string :title
      t.integer :quantity
      t.decimal :price
      t.string :size
      t.text :description
      t.timestamps
    end
  end
end
