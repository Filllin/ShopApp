class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  monetize :total_price_cents

  # Destroy object Order by product and update quantity products
  def destroy_product(quantity_of_products)
    self.destroy
    if self.order.order_items.blank?
      self.order.destroy
    end
    quantity_products = self.product.quantity_products + quantity_of_products.to_i
    self.product.update(quantity_products: quantity_products)
  end

  # Update quantity products
  def update_quantity_product(quantity_of_products, order_item_quantity)
    if order_item_quantity.present?
      quantity_products = self.product.quantity_products + quantity - quantity_of_products.to_i
    else
      quantity_products = self.product.quantity_products - quantity_of_products.to_i
    end
    total_price = quantity_of_products.to_i * self.product.price_cents
    self.product.update(quantity_products: quantity_products)
    self.update(quantity: quantity_of_products, total_price_cents: total_price)
  end
end
