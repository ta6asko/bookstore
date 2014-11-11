class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.boolean :check_del
      t.timestamps
    end
  end
end
