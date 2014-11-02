require 'rails_helper'

RSpec.describe "billing_addresses/index", :type => :view do
  before(:each) do
    assign(:billing_addresses, [
      BillingAddress.create!(),
      BillingAddress.create!()
    ])
  end

  it "renders a list of billing_addresses" do
    render
  end
end
