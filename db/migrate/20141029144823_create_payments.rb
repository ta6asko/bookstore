class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer    :number
      t.date       :expiration_date
      t.integer    :card_code

      t.timestamps
    end
  end
end
