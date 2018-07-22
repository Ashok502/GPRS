class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.date :published_at
      t.string :unique_num
      t.timestamps
    end
  end
end
