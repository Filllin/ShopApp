class DeviseCreateCustomers < ActiveRecord::Migration
  def change
    create_table(:customers) do |t|
      ## Database authenticatable
      t.string :name
      t.string :surname
      t.integer :phone_number
      t.string :bonuses
      t.string :country
      t.string :company
      t.string :first_address
      t.string :second_address
      t.string :city
      t.string :region
      t.string :postcode
      t.string :email
      t.string :session_id


      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps
    end
  end
end
