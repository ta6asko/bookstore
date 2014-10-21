class CreateBooksAuthors < ActiveRecord::Migration
  def change
    create_join_table :books, :authors
  end
end
