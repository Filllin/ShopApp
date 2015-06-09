class CustomerProduct < ActiveRecord::Base
    belongs_to :product
    belongs_to :customer
    belongs_to :coupon

    # Destroy object CustomerProduct by product and update quantity products
    def self.destroy_product(product_title, quantity_of_products, session)
      product = Product.find_by_title(product_title)
      CustomerProduct.where(user_session_id: session, product: product, customer: nil).take.destroy
      quantity_products = product.quantity_products + quantity_of_products.to_i
      product.update(quantity_products: quantity_products)
    end

    # Update quantity products
    def self.update_quantity_product(customer_product, product, quantity_of_products)
      if quantity_of_products.to_i < customer_product.quantity
        quantity_products = product.quantity_products + (customer_product.quantity - quantity_of_products.to_i)
      else
        quantity_products = product.quantity_products - (quantity_of_products.to_i - customer_product.quantity)
      end
      product.update(quantity_products: quantity_products)
      customer_product.update(quantity: quantity_of_products)
    end

    # Update total price
    def self.update_total_price(customers_product, coupon)
      customers_product.each do |customer_product|
        total_price = customer_product.quantity * (customer_product.product.price - (customer_product.product.price * coupon.percent.ceil * 0.01))
       customer_product.update(total_price: total_price)
      end
    end
  
    def self.find_exist_customer(name, surname, phone_number, country, company, first_address, second_address, city, state, postcode, email)
     return Customer.where(
          name: name,
          surname: surname,
          phone_number: phone_number,
          country: country,
          company: company,
          first_address: first_address,
          second_address: second_address,
          city: city,
          state: state,
          postcode: postcode,
          email: email
      ).take
    end
end
