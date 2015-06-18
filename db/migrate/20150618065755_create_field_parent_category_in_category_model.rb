class CreateFieldParentCategoryInCategoryModel < ActiveRecord::Migration
  def change
    add_belongs_to :categories, :parent_category
  end
end
