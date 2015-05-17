class CreateAbouts < ActiveRecord::Migration
  def change
    create_table :abouts do |t|
      t.text :content
      t.string :email
      t.text :google_maps_code
      t.text :schedule
      t.text :location

      t.timestamps null: false
    end
  end
end
