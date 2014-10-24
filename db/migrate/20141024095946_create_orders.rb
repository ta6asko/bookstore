class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string    :in_progress 
      t.string    :in_queue
      t.string    :in_delivery
      t.string    :delivered
      t.integer   :user_id
      t.timestamps
    end
  end
end
