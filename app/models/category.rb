class Category < ActiveRecord::Base
  has_many :books
  validates :rating, presence: true 

end
