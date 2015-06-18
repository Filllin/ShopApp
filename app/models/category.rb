class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  has_many :subcategories, :class_name => "Category", :foreign_key => "parent_category_id"
  belongs_to :parent_category, :class_name => "Category"
end
