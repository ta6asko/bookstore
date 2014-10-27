class Rating < ActiveRecord::Base
  belongs_to :books

  validates :rating, :title, :comment, presence: true 

end
