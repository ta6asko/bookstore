class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer     :number
      t.integer     :delivery_id
      t.string      :in_progress
      t.string      :in_queue
      t.string      :in_delivery
      t.timestamps
    end
  end
end
