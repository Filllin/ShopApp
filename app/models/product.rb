class Product < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  belongs_to :sub_category
  belongs_to :publisher
  belongs_to :author
  has_many :customer_products
  has_many :customers, through: :customer_products

  def self.search(search)
    where("(LOWER(title) LIKE :search OR LOWER(description) LIKE :search)", search: "%#{search}%")
  end
end