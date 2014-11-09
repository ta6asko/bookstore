class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_one  :cart
  has_many :orders
  has_one :billing_address
  has_one :shipping_address
  has_many :comments
  ratyrate_rater
  
end
