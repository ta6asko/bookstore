FactoryGirl.define do
  factory :payment do
    number          Faker::Number.number(16)
    expiration_date Faker::Business.credit_card_expiry_date
    card_code       Faker::Number.number(3)
  end
  
  factory :invalid_payment, parent: :payment do |f| 
    f.number nil 
  end
  
end
