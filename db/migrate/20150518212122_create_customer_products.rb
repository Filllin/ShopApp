class CreateCustomerProducts < ActiveRecord::Migration
  def change
    create_table :customer_products do |t|
      t.belongs_to :customer, index: true
      t.belongs_to :product, index: true
      t.integer :quantity
      t.integer :total_price
      t.integer :user_session_id
      t.belongs_to :coupon, index: true

      t.timestamps null: false
    end
  end
end
