require 'rails_helper'

describe BillingAddress do
  let(:shipping_address) { create(:shipping_address) }

  it { should belong_to(:user) }
  it { should belong_to(:country) }
  
  it "validates_presence_of first_name on update" do
    shipping_address.first_name = nil
    shipping_address.save
    expect(shipping_address).not_to be_valid
  end
  it "validates_presence_of last_name on update" do
    shipping_address.last_name = nil
    shipping_address.save
    expect(shipping_address).not_to be_valid
  end
  it "validates_presence_of street_address on update" do
    shipping_address.street_address = nil
    shipping_address.save
    expect(shipping_address).not_to be_valid
  end
  it "validates_presence_of city on update" do
    shipping_address.city = nil
    shipping_address.save
    expect(shipping_address).not_to be_valid
  end
  it "validates_presence_of zip on update" do
    shipping_address.zip = nil
    shipping_address.save
    expect(shipping_address).not_to be_valid
  end
  it "validates_presence_of phone on update" do
    shipping_address.phone = nil
    shipping_address.save
    expect(shipping_address).not_to be_valid
  end
end