class Category < ActiveRecord::Base
  
  has_many :books
  validates :name, uniqueness: true, :on => :update
  validates_presence_of :name

end
