class Coupon < ActiveRecord::Base
  
  validates_presence_of :number, :discount
  validates_numericality_of :discount
  validates_uniqueness_of :number

end
