class Customer < ActiveRecord::Base
  has_many :customer_products
  has_many :products, through: :customer_products

  validates :name, presence: { message: 'не может быть пустым' }
  validates :surname, presence: { message: 'не может быть пустым' }
  validates :phone_number, presence: { message: 'не может быть пустым' }, format: { with: /\d{3}-\d{3}-\d{4}/, message: "не соответствует правильному формату" }
  validates :country, presence: { message: 'не может быть пустым' }
  validates :first_address, presence: { message: 'не может быть пустым' }
  validates :city, presence: { message: 'не может быть пустым' }
  validates :postcode, presence: { message: 'не может быть пустым' }
  validates :email, presence: { message: 'не может быть пустым' }, confirmation: { message: 'не соответствует полю "E-mail адрес"' }, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "не соответствует правильному формату" }
  validates :email_confirmation, presence: { message: 'не может быть пустым' }, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "не соответствует правильному формату" }
end