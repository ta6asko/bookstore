class Payment < ActiveRecord::Base
  belongs_to :order

  validates_presence_of :number, :card_code, :expiration_date, :on => :update
  validates :number, numericality: { equal_to: 16, allow_nil: true }
  validates :card_code, numericality: { equal_to: 3, allow_nil: true }


  
end
