class CreateFeedbacks < ActiveRecord::Migration[5.2]
  def change
    create_table :feedbacks do |t|
    	t.references :user
    	t.string :title
    	t.text :body
    	t.boolean :status, default: false
      t.timestamps
    end
  end
end
