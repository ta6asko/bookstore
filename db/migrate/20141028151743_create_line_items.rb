class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.references :book, index: true
      t.belongs_to :order, index: true
      t.integer    :quantity, default: 1
      t.timestamps
    end
  end
end
