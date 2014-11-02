class ShippingAddressOrders < ActiveRecord::Migration
  def change
    create_table :shipping_addresses_orders, id: false do |t|
      t.belongs_to :shipping_address
      t.belongs_to :order
    end
  end
end
