class CreateLogos < ActiveRecord::Migration[5.2]
  def change
    create_table :logos do |t|
      t.integer :logable_id
      t.string :logable_type
      t.attachment :logo
      t.timestamps
    end
  end
end
