class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.string :description
      t.integer :reference
      t.integer :ISBN
      t.integer :number_of_pages
      t.string :format
      t.integer :weight
      t.integer :height
      t.integer :width
      t.integer :thickness
      t.belongs_to :sub_category
      t.string :slug, index: true
      t.string :image
      t.string :language
      t.money :price
      t.belongs_to :author
      t.belongs_to :publisher
      t.boolean :main
      t.integer :quantity_products

      t.timestamps null: false
    end
  end
end
