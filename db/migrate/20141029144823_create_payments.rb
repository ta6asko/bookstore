class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string    :number
      t.date      :expiration_date
      t.string    :card_code
      t.integer   :order_id
      t.timestamps
    end
  end
end
