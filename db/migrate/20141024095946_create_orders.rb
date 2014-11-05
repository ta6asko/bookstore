class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer     :delivery_id, :default => 1
      t.integer     :progress_id, :default => 1
      t.integer     :user_id
      t.timestamps
    end
  end
end
