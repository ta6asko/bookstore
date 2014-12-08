class Payment < ActiveRecord::Base
  
  belongs_to :user

  validates_presence_of     :number, :card_code, :expiration_date, :on => :update
  validates_numericality_of :number
  validates_numericality_of :card_code
  validates_length_of       :number, is: 16 
  validates_length_of       :card_code, is: 3 

end
