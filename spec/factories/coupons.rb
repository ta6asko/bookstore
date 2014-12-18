FactoryGirl.define do
  factory :coupon do
    discount Faker::Number.number(2)
    number   12345
  end
end
