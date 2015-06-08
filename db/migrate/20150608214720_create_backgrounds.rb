class CreateBackgrounds < ActiveRecord::Migration
  def change
    create_table :backgrounds do |t|
      t.string :image

      t.timestamps null: false
    end
  end
end
