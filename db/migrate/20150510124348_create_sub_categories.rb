class CreateSubCategories < ActiveRecord::Migration
  def change
    create_table :sub_categories do |t|
      t.string :title
      t.belongs_to :category, index: true
      t.string  :slug

      t.timestamps null: false
    end
    add_index :sub_categories, :slug, :unique => true
  end
end
