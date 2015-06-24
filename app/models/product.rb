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
    order = Order.find_by_user_session_id(session) || Order.create(user_session_id: session)
    order_item = OrderItem.find_by(product: self, order: order)
    order_item_quantity = true
    if order_item.blank?
      order_item = OrderItem.create(order: order, product: self, quantity: count)
      order_item_quantity = false
    end
    order_item.update_quantity_product(count, order_item_quantity)
  end
end