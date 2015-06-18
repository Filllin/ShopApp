class CreateFieldParentsInCategoryModel < ActiveRecord::Migration
  def change
      add_reference :categories, :parent
  end
end
