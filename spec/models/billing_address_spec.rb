require 'rails_helper'

describe BillingAddress do
  let(:billing_address) { create(:billing_address) }

  it { should belong_to(:user) }
  it { should belong_to(:country) }
  
  it "validates_presence_of first_name on update" do
    billing_address.first_name = nil
    billing_address.save
    expect(billing_address).not_to be_valid
  end
  it "validates_presence_of last_name on update" do
    billing_address.last_name = nil
    billing_address.save
    expect(billing_address).not_to be_valid
  end
  it "validates_presence_of street_address on update" do
    billing_address.street_address = nil
    billing_address.save
    expect(billing_address).not_to be_valid
  end
  it "validates_presence_of city on update" do
    billing_address.city = nil
    billing_address.save
    expect(billing_address).not_to be_valid
  end
  it "validates_presence_of zip on update" do
    billing_address.zip = nil
    billing_address.save
    expect(billing_address).not_to be_valid
  end
  it "validates_presence_of phone on update" do
    billing_address.phone = nil
    billing_address.save
    expect(billing_address).not_to be_valid
  end
end