class Product < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  belongs_to :category
  belongs_to :publisher
  belongs_to :author
  monetize :price_cents
  mount_uploader :image, ImageUploader

  # Add object Product to Cart
  def add_product_to_cart(count, session)
    quantity_products = self.quantity_products - count.to_i
    self.update(quantity_products: quantity_products)
    self.create_order_item(count, session)
  end

  # Create object Order
  def create_order_item(count, session)
    order = Order.find_by_user_session_id(session) || Order.create(user_session_id: session, status: 'Received')
    order_item = OrderItem.find_by(product: self, order: order)
    if order_item.present?
      order_item.update_quantity_product(count)
    else
      OrderItem.create(order: order, product: self, quantity: count)
    end
  end
end