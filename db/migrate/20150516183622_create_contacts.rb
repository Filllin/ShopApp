class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.text   :content
      t.string :email
      t.string :phone_numbers

      t.timestamps null: false
    end
  end
end
