class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer  :rating
      t.integer  :book_id

      t.timestamps
    end
  end
end
