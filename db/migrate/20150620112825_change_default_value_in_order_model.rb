class ChangeDefaultValueInOrderModel < ActiveRecord::Migration
  def change
    change_column :orders, :status, :string, :default => 'Cart'
  end
end
