class Order < ActiveRecord::Base
    has_many :order_items
    has_many :products, through: :order_items
    belongs_to :customer
    belongs_to :coupon
    monetize :total_price_cents

    STATUS = {
        "Received" => "Received",
        "Waiting for payment" => "Waiting for payment",
        "On hold" => "On-hold",
        "Processing" => "Processing",
        "Shipped" => "Shipped",
        "Completed" => "Completed"
    }

    enum status: STATUS

    after_update :send_email_about_order_status,
                 if: lambda { |order|
                    order[:status] == 'Waiting for payment' ||
                    order[:status] == 'On-hold' ||
                    order[:status] == 'Processing' ||
                    order[:status] == 'Shipped' ||
                    order[:status] == 'Completed'
                 }


    # Update total price
    def update_total_price_cents(coupon)
      array = Array.new
      a = 0
      self.order_items.each do |i|
        if coupon.present?
          array[a] = i.quantity * (i.product.price_cents - (i.product.price_cents * coupon.percent.ceil * 0.01))
        else
          array[a] = i.quantity * i.product.price_cents
        end
        a += 1
      end
      self.update(total_price_cents: array.sum)
    end

    # Send email about order status
    protected
    def send_email_about_order_status
      SendMailer.send_email_about_order_status(self.status, self.customer.email).deliver_now
    end
end
