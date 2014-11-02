class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :delivery
  has_and_belongs_to_many :billing_address
  has_and_belongs_to_many :shipping_address

end

