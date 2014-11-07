class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer    :user_id
      t.integer    :book_id
      t.string     :photo_id 
      t.integer    :value, :default => 0
      t.string     :title
      t.text       :comment
      t.timestamps
    end
  end
end
