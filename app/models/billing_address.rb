class BillingAddress < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :country
  
  validates_presence_of :first_name, :last_name, :street_address, :city, :zip, :phone, :on => :update 

end
