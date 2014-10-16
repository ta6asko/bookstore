class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string 	:title
      t.text		:short_description
			t.text 		:full_description
			t.float 	:price
 
      t.timestamps
    end

    create_table :authors do |t|
    	
    end

    create_table :categories do |t|
    	
    end
  end
end
