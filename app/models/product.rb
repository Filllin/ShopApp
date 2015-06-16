class Product < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  belongs_to :sub_category
  belongs_to :publisher
  belongs_to :author
  monetize :price
  mount_uploader :image, ImageUploader

  # Return search result
  def self.search(search, title_sub_category)
    sub_categories = SubCategory.where(title: title_sub_category)
    author = object_registers(Author, search)
    if author.blank?
     return where(author_id: author)
    else
    products = object_register(Product, search)
    puts products.blank?
      if products.blank? == false && sub_categories.present?
      return products.where(sub_category_id: sub_categories)
      elsif products.blank? == false && sub_categories.present? == false
      return products
      else
        where(sub_category_id: sub_categories)
      end
    end
  end

  # Check object on register
  protected
  def self.object_register(model, search)
    object = {'downcase' => search.mb_chars.downcase.to_s,
              'upcase' => search.mb_chars.upcase.to_s,
              'capitalize_first_word' => search.mb_chars.capitalize.to_s,
              'capitalize_every_word' => search.mb_chars.split.map(&:capitalize).join(' ')
             }
    object_arel_table = model.arel_table
    object.each do |key, value|
      total_object = model.where(object_arel_table[:title].matches(value))
      if total_object.present?
        return total_object
      end
    end
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