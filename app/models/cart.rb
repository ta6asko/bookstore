class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  belongs_to :user

  def add_book(book_id, count)
    current_item = line_items.find_by(book_id: book_id)
    count = count.to_i
    if current_item
      current_item.quantity += count
        else
      current_item = line_items.build(book_id: book_id, quantity: count)
    end
    
    current_item
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end

end
