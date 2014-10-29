require 'rails_helper'

RSpec.describe "billing_addresses/edit", :type => :view do
  before(:each) do
    @billing_address = assign(:billing_address, BillingAddress.create!())
  end

  it "renders the edit billing_address form" do
    render

    assert_select "form[action=?][method=?]", billing_address_path(@billing_address), "post" do
    end
  end
end
