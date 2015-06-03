class Product < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  belongs_to :sub_category
  belongs_to :publisher
  belongs_to :author
  has_many :customer_products
  has_many :customers, through: :customer_products
  mount_uploader :image, ImageUploader

  # Return search result
  def self.search(search)
    where("(LOWER(title) LIKE :search OR LOWER(description) LIKE :search)", search: "%#{search}%")
  end

  # Return products by category
  def self.count_products_by_category(slug_category, count, page, sort_column, sort_direction)
    return Product.where(sub_category: SubCategory.where(category: slug_category)).order(sort_column + " " + sort_direction).paginate(:per_page => count, :page => page)
  end

  # Return products by sub_category
  def self.count_products_by_sub_category(slug, count, page, sort_column, sort_direction)
    return Product.where(sub_category: SubCategory.find_by_slug(slug)).order(sort_column + " " + sort_direction).paginate(:per_page => count, :page => page)
  end

  # Add object Product to Cart
  def self.add_product_to_cart(product, count, session)
    quantity_products = product.quantity_products - count.to_i
    product.update(quantity_products: quantity_products)
    Product.create_customer(product, count, session)
  end

  # Create object CustomerProduct
  def self.create_customer(product, count, session)
    customer_product = CustomerProduct.where(user_session_id: session, product: product, customer: nil).take
    if customer_product.present?
      quantity = count.to_i + customer_product.quantity
      customer_product.update(quantity: quantity)
    else
      CustomerProduct.create(user_session_id: session, product: product, quantity: count)
    end
  end
end