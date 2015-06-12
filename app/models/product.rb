class Product < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  belongs_to :sub_category
  belongs_to :publisher
  belongs_to :author
  mount_uploader :image, ImageUploader

  # Return search result
  def self.search(search)
    where("(LOWER(title) LIKE :search OR LOWER(description) LIKE :search)", search: "%#{search}%")
  end

  # Return products by category
  def self.count_products_by_category(slug_category, count, page, sort_column, sort_direction)
    return Product.where(sub_category: SubCategory
                  .where(category: slug_category))
                  .order(sort_column + " " + sort_direction)
                  .paginate(:per_page => count, :page => page)
  end

  # Return products by sub_category
  def self.count_products_by_sub_category(sub_category, count, page, sort_column, sort_direction)
    return Product.where(sub_category: sub_category)
                  .order(sort_column + " " + sort_direction)
                  .paginate(:per_page => count, :page => page)
  end

  # Add object Product to Cart
  def self.add_product_to_cart(product, count, session)
    quantity_products = product.quantity_products - count.to_i
    product.update(quantity_products: quantity_products)
    Product.create_customer(product, count, session)
  end

  # Create object Order
  def self.create_customer(product, count, session)
    order = Order.find_by(user_session_id: session, product: product, customer: nil)
    if order.present?
      quantity = count.to_i + order.quantity
      order.update(quantity: quantity)
    else
      Order.create(user_session_id: session, product: product, quantity: count)
    end
  end
end