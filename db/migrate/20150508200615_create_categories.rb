class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :book

      t.timestamps null: false
    end
  end
end
