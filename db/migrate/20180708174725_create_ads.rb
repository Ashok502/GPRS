class CreateAds < ActiveRecord::Migration[5.2]
  def change
    create_table :ads do |t|

    	t.references :user
    	t.attachment :image
      t.timestamps
    end
  end
end
