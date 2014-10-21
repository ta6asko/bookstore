class Book < ActiveRecord::Base
  
  
  has_and_belongs_to_many :authors
  belongs_to :category

  validates :price, numericality: { greater_then: 0, allow_nil: true }
  validates :title, :short_description, :full_description, presence: true 

  mount_uploader :image, AvatarUploader
end