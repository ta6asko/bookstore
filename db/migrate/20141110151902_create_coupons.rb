class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.integer  :discount
      t.integer  :number
      t.timestamps
    end
  end
end
