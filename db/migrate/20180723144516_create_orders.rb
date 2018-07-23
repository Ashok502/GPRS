class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
    	t.references :user
    	t.references :cart 
    	t.string  :ip_address
      t.string  :first_name
      t.string  :last_name
      t.date    :card_expires_on
      t.string :card_type
      t.string  :action
      t.decimal :amount
      t.boolean :success
      t.string  :authorization
      t.string  :message
      t.text    :params
      t.string  :payment_type
      t.string :express_token
      t.string :express_payer_id
      t.timestamps
    end
  end
end
