FactoryGirl.define do
  factory :line_item do
    price 100
    quantity 4
    book
    order
  end
end
