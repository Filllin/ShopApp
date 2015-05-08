class Books < ActiveRecord::Base
  has_many :categories
end
