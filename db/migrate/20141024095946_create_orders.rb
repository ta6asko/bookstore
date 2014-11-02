class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer     :number
      t.integer     :delivery_id
      t.timestamps
    end
  end
end
