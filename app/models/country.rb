class Country < ActiveRecord::Base
  has_many :billing_addresses
  has_many :shipping_addresses

  validates_presence_of :name
  validates_uniqueness_of :name
end
