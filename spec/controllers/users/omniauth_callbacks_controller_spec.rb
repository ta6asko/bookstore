require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, :type => :controller do

  describe "GET facebook" do
    it "returns http success" do
      get :facebook
      expect(response).to be_success
    end
  end

end
