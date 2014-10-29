require 'rails_helper'

RSpec.describe "billing_addresses/new", :type => :view do
  before(:each) do
    assign(:billing_address, BillingAddress.new())
  end

  it "renders new billing_address form" do
    render

    assert_select "form[action=?][method=?]", billing_addresses_path, "post" do
    end
  end
end
