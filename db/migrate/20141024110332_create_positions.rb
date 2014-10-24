class CreatePositions < ActiveRecord::Migration
  def up
    create_table :positions do |t|
      t.integer  :cart_id
      t.integer  :book_id
      t.integer  :quantity 
      t.timestamps
    end
    drop_table :carts_books
  end
end
