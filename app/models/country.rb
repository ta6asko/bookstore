class Country < ActiveRecord::Base
  has_many :billing_addresses
  has_many :shipping_addresses

  validates :name, presence: true
  validates :name, uniqueness: true
end
