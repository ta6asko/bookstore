class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string 	:title
      t.float   :author_id
      t.text		:short_description
			t.text 		:full_description
      t.string  :image
			t.float 	:price
 
      t.timestamps
    end
  end
end
