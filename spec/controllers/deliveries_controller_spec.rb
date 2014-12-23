require 'controllers/controllers_spec_helper'

describe DeliveriesController do
  before do
    @user = create(:user)
    allow(controller).to receive(:current_user) { @user }
    @delivery = create(:delivery)
    redefine_cancan_abilities
  end

  context "GET #edit" do
    context 'being signed in' do
      before do
        sign_in @user
        get :edit, id: @delivery.id
      end

      it "responds successfully with an HTTP 200 status code" do
        expect(response.status).to eq(200)
      end

      it "renders the edit template" do
        expect(response).to render_template("edit")
      end
    end

    context 'being not signed in' do
      before do
        get :edit, id: @delivery.id
      end

      it { should redirect_to new_user_session_path }
    end

    context 'cancan doesnt allow :edit' do
      before do
        sign_in @user
        @ability.cannot :edit, Delivery
        get :edit, id: @delivery.id
      end

      it { should redirect_to root_path }

    end
  end
end