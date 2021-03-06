class Order < ActiveRecord::Base

  belongs_to :delivery
  belongs_to :user
  
  has_many   :line_items, dependent: :destroy

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

  def subtotal(discount)
    subtotal = line_items.to_a.sum { |item| item.total_price }
    subtotal -= discount if discount > 0
    subtotal
  end

  def total
    line_items.to_a.sum { |item| item.total_price }
  end  
  
  def set_progress(progress)
    if progress == 'in_progress'
      @status = "In progress"
    elsif progress == 'in_queue'
      @status = "In queue"
    elsif progress == 'in_delivery'
      @status = "In delivery" 
    elsif progress == 'delivered'
      @status = "Delivered" 
    end
    @status
   end 

  rails_admin do
    edit do
      field :user
      field :progress
    end

    show do
      field :user
      field :progress
    end
  end
end

