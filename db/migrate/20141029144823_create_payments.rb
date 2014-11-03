class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.decimal    :number
      t.date       :expiration_date
      t.integer    :card_code

      t.timestamps
    end
  end
end
