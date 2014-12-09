require 'rails_helper'

describe Order do
  it { should belong_to(:delivery) }
  it { should belong_to(:user) }
  it { should have_many(:line_items).dependent(:destroy) }

  it "add book to line_item & calculation quantity" do
    book = create(:book)
    line_item = create(:line_item)
    book_id = book.id
    count = line_item.quantity
    
  end
end