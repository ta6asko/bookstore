class Delivery < ActiveRecord::Base
  
  has_many :orders

  validates_presence_of :name
  validates_numericality_of :price
  validates_uniqueness_of :name

end
