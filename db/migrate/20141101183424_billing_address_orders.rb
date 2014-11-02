class BillingAddressOrders < ActiveRecord::Migration
  def change
    create_table :billing_addresses_orders, id: false do |t|
      t.belongs_to :billing_address
      t.belongs_to :order
    end
  end
end
