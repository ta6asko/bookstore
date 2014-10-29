class CreateBillingAddresses < ActiveRecord::Migration
  def change
    create_table :billing_addresses do |t|
      t.string :first_name
      t.string :last_name
      t.string :street_address
      t.string :city
      t.string :country
      t.string :zip
      t.string :phone
      t.timestamps
    end
  end
end
