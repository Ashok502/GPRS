class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
    	t.references :product
    	t.references :user
    	t.decimal :rating
    	t.text :description
      t.timestamps
    end
  end
end
