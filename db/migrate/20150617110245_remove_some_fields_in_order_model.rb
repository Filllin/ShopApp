class RemoveSomeFieldsInOrderModel < ActiveRecord::Migration
  def change
    remove_column :orders, :product_id
    remove_column :orders, :total_price
    remove_column :orders, :customer_id
    remove_column :orders, :quantity
  end
end
