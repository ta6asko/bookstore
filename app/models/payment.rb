class Payment < ActiveRecord::Base
  
  belongs_to :order

  validates_presence_of :number, :card_code, :expiration_date, :on => :update
  validates_numericality_of :number, equal_to: 16
  validates_numericality_of :card_code, equal_to: 3

end
