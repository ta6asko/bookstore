FactoryGirl.define do
  factory :book do
    title Faker::Name.title
    full_description "full_description"
    price 100
  end
end