class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.integer :user_id
      t.integer :discount, default: 0
      t.integer :coupon_number
      
      t.timestamps
    end
  end
end
