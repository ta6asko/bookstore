class Order < ActiveRecord::Base
  has_one :billing_address
  has_one :shipping_address
  belongs_to :user
  belongs_to :delivery
end

