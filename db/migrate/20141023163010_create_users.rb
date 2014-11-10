class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.boolean :check_del
      t.integer :coupon
      t.timestamps
    end
  end
end
