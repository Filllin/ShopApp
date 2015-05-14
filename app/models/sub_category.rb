class SubCategory < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  belongs_to :category
  has_many :books
end
