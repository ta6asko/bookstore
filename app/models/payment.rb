class Payment < ActiveRecord::Base
  
  belongs_to :user

  validates_presence_of     :number, :card_code, :expiration_date, :on => :update
  validates_numericality_of :number, :on => :update
  validates_numericality_of :card_code, :on => :update
  validates_length_of       :number, is: 16, :on => :update 
  validates_length_of       :card_code, is: 3, :on => :update 

end
