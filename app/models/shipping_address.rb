class ShippingAddress < ActiveRecord::Base
  belongs_to :orders
  belongs_to :country

  validates :first_name, :last_name, :street_address, :city, :country_id, :zip, :phone, presence: true
end
