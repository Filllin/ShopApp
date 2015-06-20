class Author < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  has_many :products

  # Return products by author
  def count_products(count, page, sort_column, sort_direction)
    self.products.where(author: self)
                 .order(sort_column + " " + sort_direction)
                 .paginate(:per_page => count, :page => page)
  end
end
