FactoryGirl.define do
  factory :comment do
    title       Faker::Name.title
    comment     Faker::Lorem.paragraph
    user_name   Faker::Name.name
  end
end
