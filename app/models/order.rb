class Order < ActiveRecord::Base
    has_many :order_items
    has_many :products, through: :order_items
    belongs_to :customer
    belongs_to :coupon
    monetize :price

    STATUS = {
        "Received" => "Received",
        "Waiting for payment" => "Waiting for payment",
        "On hold" => "On-hold",
        "Processing" => "Processing",
        "Shipped" => "Shipped",
        "Completed" => "Completed"
    }

    enum status: STATUS

    after_update :send_email_about_order_status, if: lambda { |order|
                                                  order[:status] == 'Waiting for payment' ||
                                                  order[:status] == 'On-hold' ||
                                                  order[:status] == 'Processing' ||
                                                  order[:status] == 'Shipped' ||
                                                  order[:status] == 'Completed'
                                               }

    # Send email about order status
    protected
    def send_email_about_order_status
      SendMailer.send_email_about_order_status(self.status, self.customer.email).deliver_now
    end

    # Destroy object Order by product and update quantity products
    def self.destroy_product(product_title, quantity_of_products, session)
      product = Product.find_by_title(product_title)
      Order.find_by(user_session_id: session, product: product, customer: nil).destroy
      quantity_products = product.quantity_products + quantity_of_products.to_i
      product.update(quantity_products: quantity_products)
    end

    # Update quantity products
    def self.update_quantity_product(order, product, quantity_of_products)
      if quantity_of_products.to_i < order.quantity
        quantity_products = product.quantity_products + (order.quantity - quantity_of_products.to_i)
      else
        quantity_products = product.quantity_products - (quantity_of_products.to_i - order.quantity)
      end
      product.update(quantity_products: quantity_products)
      order.update(quantity: quantity_of_products)
    end

    # Update total price
    def self.update_total_price(orders, coupon)
      orders.find_each do |order|
        total_price = order.quantity * (order.product.price - (order.product.price * coupon.percent.ceil * 0.01))
       order.update(total_price: total_price)
      end
    end

    # Find exist customer
    def self.find_exist_customer(
            name,
            surname,
            phone_number,
            country,
            company,
            first_address,
            second_address,
            city,
            state,
            postcode,
            email
      )
      Customer.find_by(
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
      )
    end
end
