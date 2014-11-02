require 'rails_helper'

RSpec.describe "billing_addresses/show", :type => :view do
  before(:each) do
    @billing_address = assign(:billing_address, BillingAddress.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
