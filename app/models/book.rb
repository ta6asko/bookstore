class Book < ActiveRecord::Base
  
  has_and_belongs_to_many :authors
  has_many :line_items
  has_many :comments
  belongs_to :category

  validates :title, uniqueness: true
  validates :price, numericality: { greater_then: 0 }
  validates_presence_of :title, :full_description, :price 

  mount_uploader :image, AvatarUploader

  before_destroy :ensure_not_referenced_by_any_line_item

  private

  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'существуют товарные позиции')
      return false
    end
  end

  def average_rating
    @value = 0
    self.ratings.each do |rating|
        @value = @value + rating.value
    end
    @total = self.ratings.size
    @value.to_f / @total.to_f
  end
  


  # rails_admin do
  #   edit do
  #     field :title
  #     field :full_description
  #     field :image
  #     field :price
  #     field :category
  #   end

  #   show do
  #     field :title
  #     field :full_description
  #     field :image
  #     field :price
  #     field :category
  #   end
  # end
end