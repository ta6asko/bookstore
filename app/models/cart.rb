class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  # belongs_to :user
  # has_many   :positions
  # has_many   :books, through: :positions
end
