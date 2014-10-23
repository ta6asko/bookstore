class AddColumnToRating < ActiveRecord::Migration
  def change
    add_column :ratings, :comment, :text
    add_column :ratings, :title, :string
  end
end
