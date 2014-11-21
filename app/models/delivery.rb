class Delivery < ActiveRecord::Base
  
  has_many :orders

  validates_presence_of :name
  validates :price, numericality: { greater_then: 0, allow_nil: true }
  validates :name, uniqueness: true

end
