class CreateIntrests < ActiveRecord::Migration[5.2]
  def change
    create_table :intrests do |t|

      t.references :user
      t.string :name
      t.timestamps
    end
  end
end
