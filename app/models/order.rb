class Order < ActiveRecord::Base
  belongs_to :user
  has_one :billing_address
end
