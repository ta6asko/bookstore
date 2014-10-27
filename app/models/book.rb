class Book < ActiveRecord::Base
  
  
  has_and_belongs_to_many :authors

  has_many :positions
  has_many :carts, through: :positions
  
  belongs_to :categoryhas_adn_belongs_to_many
  belongs_to :rating

  validates :price, numericality: { greater_then: 0, allow_nil: true }
  validates :title, :short_description, :full_description, :author, :image, presence: true 
  validates :title, uniqueness: true
  mount_uploader :image, AvatarUploader
end