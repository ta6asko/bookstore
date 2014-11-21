class BillingAddress < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :country
  
  validates_presence_of :first_name, :last_name, :street_address, :city, :zip, :phone, :on => :update 
  # validates :phone, numericality: { equal_to: 12 }
  # validates :zip, numericality: { equal_to: 5 }

end
