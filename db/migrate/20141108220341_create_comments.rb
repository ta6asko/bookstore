class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string   :title
      t.text     :comment
      t.text     :user_name
      t.integer  :user_id
      t.integer  :book_id
      t.timestamps
    end
  end
end
