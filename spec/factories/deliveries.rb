FactoryGirl.define do
  factory :delivery do
    name   Faker::Name.title
    price  Faker::Number.number(2)
  end

end
