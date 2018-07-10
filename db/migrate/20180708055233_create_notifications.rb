class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|

    	t.references :user
    	t.references :post
    	t.boolean :read_at, default: true
      t.timestamps
    end
  end
end
