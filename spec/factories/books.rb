FactoryGirl.define do
  factory :book do
    title Faker::Name.title
    full_description Faker::Lorem.paragraph
    price 100
  end
end