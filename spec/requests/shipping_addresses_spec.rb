require 'rails_helper'

RSpec.describe "ShippingAddresses", :type => :request do
  describe "GET /shipping_addresses" do
    it "works! (now write some real specs)" do
      get shipping_addresses_path
      expect(response.status).to be(200)
    end
  end
end
