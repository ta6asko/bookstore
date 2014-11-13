class CombineItemsInOrder < ActiveRecord::Migration
  def change
    def up
      Order.all.each do |order|
        summ = order.line_items.group(:book_id).sum(:quantity)
        summ.each do |book_id, quantity|
          if quantity > 1
            order.line_items.where(book_id: book_id).delete_all
            item = order.line_items.build(book_id: book_id)
            item.quantity = quantity
            item.save!
          end
        end
      end
    end
  end

  def down
    LineItem.where("quantity>1").each do |line_item|
      line_item.quantity.times do
        LineItem.create order_id: line_item.order_id, book_id: line_item.book_id, quantity: 1 
        line_item.destroy
      end
    end
  end
end
