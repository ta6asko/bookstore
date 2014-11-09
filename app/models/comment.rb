class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  ratyrate_rateable "title"
end
