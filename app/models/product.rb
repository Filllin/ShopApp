class Product < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  belongs_to :sub_category
  belongs_to :publisher
  belongs_to :author
  has_many :customer_products
  has_many :customers, through: :customer_products

  def self.search(search)
    where("(LOWER(title) LIKE :search OR LOWER(description) LIKE :search)", search: "%#{search}%")
  end

  def self.count_products_by_category(slug_category, count, page, sort_column, sort_direction)
    return Product.where(sub_category: SubCategory.where(category: slug_category)).order(sort_column + " " + sort_direction).paginate(:per_page => count, :page => page)
  end

  def self.count_products_by_sub_category(slug, count, page, sort_column, sort_direction)
    return Product.where(sub_category: SubCategory.find_by_slug(slug)).order(sort_column + " " + sort_direction).paginate(:per_page => count, :page => page)
  end
end