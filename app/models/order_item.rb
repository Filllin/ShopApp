class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  monetize :total_price_cents

  # Destroy object Order by product and update quantity products
  def destroy_product(quantity_of_products)
    self.destroy
    quantity_products = self.product.quantity_products + quantity_of_products.to_i
    self.product.update(quantity_products: quantity_products)
  end

  # Update quantity products
  def update_quantity_product(quantity_of_products)
    if quantity_of_products.to_i < self.quantity
      quantity_products = self.product.quantity_products + (self.quantity - quantity_of_products.to_i)
    else
      quantity_products = self.product.quantity_products - (quantity_of_products.to_i - self.quantity)
    end
    self.product.update(quantity_products: quantity_products)
    self.update(quantity: quantity_of_products)
  end
end
