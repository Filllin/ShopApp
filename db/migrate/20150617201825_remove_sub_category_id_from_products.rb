class RemoveSubCategoryIdFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :sub_category_id
  end
end
