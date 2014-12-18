require 'controllers/controllers_spec_helper'

describe ShippingAddressesController do
  before do
    @user = create(:user)
    allow(controller).to receive(:current_user) { @user }
    @shipping_address = create(:shipping_address)
    redefine_cancan_abilities
  end

  context "GET #edit" do
    context 'being signed in' do
      before (:each) do
        sign_in @user
        get :edit, id: @shipping_address.id
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
        get :edit, id: @shipping_address.id
      end

      it { should redirect_to new_user_session_path }
    end

    context 'cancan doesnt allow :edit' do
      before do
        sign_in @user
        @ability.cannot :edit, ShippingAddress
        get :edit, id: @shipping_address.id
      end

      it { should redirect_to root_path }
    end
  end

  context "PATCH #update" do 
    context 'being signed in' do
      before (:each) do
        sign_in @user
      end

      it "render 'edit' if shipping_address is invalid" do
        patch :update, id: @shipping_address.id, shipping_address: attributes_for(:invalid_address) 
        response.should render_template :edit
      end

      it "redirects to edit_shipping_address_path if shipping_address is valid" do
        patch :update, id: @shipping_address.id, shipping_address: attributes_for(:shipping_address)
        response.should redirect_to edit_delivery_path
      end
    end

    context 'being not signed in' do
      before do
        patch :update, id: @shipping_address.id, shipping_address: attributes_for(:shipping_address)
      end

      it { should redirect_to new_user_session_path }
    end

    context 'cancan doesnt allow :update' do
      before do
        sign_in @user
        @ability.cannot :update, ShippingAddress
        patch :update, id: @shipping_address.id, shipping_address: attributes_for(:shipping_address)
      end

      it { should redirect_to root_path }
    end
  end
end