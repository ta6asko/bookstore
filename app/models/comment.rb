class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  ratyrate_rateable "title"
  validates_presence_of :title, :comment, :user_name
end
