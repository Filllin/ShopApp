class CreateFieldTotalPriceInOrderItemModel < ActiveRecord::Migration
  def change
    add_money :order_items, :total_price
  end
end
