class CreateFieldTotalPriceInOrderItemModel < ActiveRecord::Migration
  def change
    add_monetize :order_items, :total_price
  end
end
