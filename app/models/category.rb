class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  has_many :subcategories, :class_name => "Category", :foreign_key => "parent_category_id"
  belongs_to :parent_category, :class_name => "Category"

  # Return products by category
  def count_products_by_category(count, page, sort_column, sort_direction)
    main_category = self.subcategories
    if main_category.blank?
      main_category = self
    end
    Product.where(category: main_category)
           .order(sort_column + " " + sort_direction)
           .paginate(:per_page => count, :page => page)
  end
end
