class AddStateToUsers < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :country, :string
  	add_column :users, :state, :string
  	add_column :users, :city, :string
  	add_column :users, :pincode, :string
  end
end
