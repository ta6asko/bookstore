require 'rails_helper'

describe BillingAddress do
  let(:billing_address) { BillingAddress.create }

  it { should belong_to(:user) }
  it { should belong_to(:country) }
  # it { should validate_numericality_of(:phone).is_equal_to(12) }
  # it { should validate_numericality_of(:zip).is_equal_to(5) }
  
  it "validates_presence_of first_name on update" do
    billing_address.first_name = '12'
    billing_address.save
    expect(billing_address).not_to be_valid
  end

  # it { should validate_presence_of(:last_name) }
  # it { should validate_presence_of(:street_address) }
  # it { should validate_presence_of(:city) }
  # it { should validate_presence_of(:zip) }
  # it { should validate_presence_of(:phone) }

end