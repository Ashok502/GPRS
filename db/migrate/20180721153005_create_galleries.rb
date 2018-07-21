class CreateGalleries < ActiveRecord::Migration[5.2]
  def change
    create_table :galleries do |t|
      t.references :user
      t.attachment :image
      t.timestamps
    end
  end
end
