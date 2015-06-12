class Author < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  has_many :products

  # Return products by author
  def self.count_products(count, author, page, sort_column, sort_direction)
      return Product.where(author: author)
                    .order(sort_column + " " + sort_direction)
                    .paginate(:per_page => count, :page => page)
  end
end
