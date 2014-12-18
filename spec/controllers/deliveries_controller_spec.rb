require 'controllers/controllers_spec_helper'

describe DeliveriesController do
  before do
    @delivery = create(:delivery)
    redefine_cancan_abilities
  end

  context "GET #edit" do
    before do
      get :edit, id: @delivery.id 
    end

    it "responds successfully with an HTTP 200 status code" do
      expect(response.status).to eq(200)
    end
  end 
end