class Customer < ActiveRecord::Base
  has_many :customer_products
  has_many :products, through: :customer_products

  validates :name, presence: { message: 'не может быть пустым' }
  validates :surname, presence: { message: 'не может быть пустым' }
  validates :phone_number, presence: { message: 'не может быть пустым' }
  validates :country, presence: { message: 'не может быть пустым' }
  validates :first_address, presence: { message: 'не может быть пустым' }
  validates :city, presence: { message: 'не может быть пустым' }
  validates :postcode, presence: { message: 'не может быть пустым' }
  validates :email, presence: { message: 'не может быть пустым' }
end
