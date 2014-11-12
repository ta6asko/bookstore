class Order < ActiveRecord::Base

  belongs_to :user
  belongs_to :delivery
  has_one    :payment


end

