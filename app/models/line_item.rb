class LineItem < ActiveRecord::Base
  belongs_to :book
  belongs_to :order

  def total_price
    book.price * quantity
  end

end
