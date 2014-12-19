FactoryGirl.define do
  factory :delivery do
    name   'UPS Two Day'
    price  Faker::Number.number(2)
  end

end
