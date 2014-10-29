require 'rails_helper'

RSpec.describe "Addresses", :type => :request do
  describe "GET /addresses" do
    it "works! (now write some real specs)" do
      get addresses_path
      expect(response.status).to be(200)
    end
  end
end
