class CreateCartsBooks < ActiveRecord::Migration
  def change
    create_table :carts_books, id: false do |t|
      t.integer :cart_id
      t.integer :books_id
    end
  end
end
