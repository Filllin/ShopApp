class CustomerProduct < ActiveRecord::Base
    belongs_to :product
    belongs_to :customer

    def self.destroy_product(product_title, quantity_of_products, session)
      product = Product.find_by_title(product_title)
      CustomerProduct.where(user_session_id: session, product: product, customer: nil).take.destroy
      quantity_products = product.quantity_products + quantity_of_products.to_i
      product.update(quantity_products: quantity_products)
    end

    def self.update_quantity_product(customer_product, product, quantity_of_products)
      if quantity_of_products.to_i < customer_product.quantity
        quantity_products = product.quantity_products + (customer_product.quantity - quantity_of_products.to_i)
      else
        quantity_products = product.quantity_products - (quantity_of_products.to_i - customer_product.quantity)
      end
      product.update(quantity_products: quantity_products)
      customer_product.update(quantity: quantity_of_products)
    end
end
