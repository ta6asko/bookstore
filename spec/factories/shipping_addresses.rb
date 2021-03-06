FactoryGirl.define do
  factory :shipping_address do
    first_name       Faker::Name.first_name 
    last_name        Faker::Name.last_name 
    street_address   Faker::Address.street_name 
    city             Faker::Address.city 
    zip              Faker::Address.zip 
    phone            Faker::PhoneNumber.phone_number  
  end
end