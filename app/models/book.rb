class Book < ActiveRecord::Base
  validates :price, numericality: { greater_then: 0, allow_nil: true }
  validates :title, :short_description, :full_description, presence: true 

  mount_uploader :image, AvatarUploader
end
