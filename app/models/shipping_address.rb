class ShippingAddress < ActiveRecord::Base
  has_and_belongs_to_many :orders
  belongs_to :country

  validates :first_name, :last_name, :street_address, :city, :country_id, :zip, :phone, presence: true
end
