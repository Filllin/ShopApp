class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :description
      t.integer :reference
      t.integer :ISBN
      t.string  :author
      t.string  :publisher
      t.integer :number_of_pages
      t.string  :format
      t.integer :weight
      t.integer :height
      t.integer :width
      t.integer :thickness
      t.belongs_to  :sub_category, index: true
      t.string  :slug


      t.timestamps null: false
    end
    add_index :books, :slug, :unique => true
  end
end
