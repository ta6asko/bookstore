
require 'spec_helper'

describe LineItem do

  it "calculation total price" do
    book = create(:book)
    line_item = create(:line_item, book_id: book.id)
    expect(line_item.total_price).to eq(300)
  end

  it { should belong_to(:order) }
  it { should belong_to(:book) }
end