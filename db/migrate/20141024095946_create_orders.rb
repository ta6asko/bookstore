class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer     :user_id
      t.integer     :delivery_id, :default => 1
      t.string      :progress, default: 'in_progress'
      t.integer     :user_id
      t.integer     :discount, default: 0
      t.integer     :coupon_number
      t.timestamps
    end
  end
end
