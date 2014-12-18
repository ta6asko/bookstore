FactoryGirl.define do
  factory :order do
    delivery_id 1
  end
  factory :delivery_id, parent: :order do |f| 
    f.street_address 2 
  end
end
