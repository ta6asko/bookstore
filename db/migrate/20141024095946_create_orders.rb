class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer     :delivery_id
      t.integer     :progress_id
      t.integer     :user_id
      t.timestamps
    end
  end
end
