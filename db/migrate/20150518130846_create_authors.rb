class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :title
      t.string :slug, index: true

      t.timestamps null: false
    end
  end
end
