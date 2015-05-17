class CreateSubCategories < ActiveRecord::Migration
  def change
    create_table :sub_categories do |t|
      t.string :title
      t.belongs_to :category, index: true
      t.string :slug, index: true

      t.timestamps null: false
    end
  end
end
