class Coupon < ActiveRecord::Base
  
  validates_presence_of :number, :discount
  validates :discount, numericality: { greater_then: 0, allow_nil: true }
  validates :number, uniqueness: true

end
