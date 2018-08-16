class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
    	t.string :title
    	t.date :start_date
    	t.date :end_date
    	t.references :user
      t.timestamps
    end
  end
end
