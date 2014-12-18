require 'controllers/controllers_spec_helper'

describe BillingAddressesController do
  before do
    @user = create(:user)
    allow(controller).to receive(:current_user) { @user }
    @billing_address = create(:billing_address)
    redefine_cancan_abilities
  end

  context "GET #edit" do
    context 'being signed in' do
      before do
        sign_in @user
        get :edit, id: @billing_address.id
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
        get :edit, id: @billing_address.id
      end

      it { should redirect_to new_user_session_path }
    end

    context 'cancan doesnt allow :edit' do
      before do
        sign_in @user
        @ability.cannot :edit, BillingAddress
        get :edit, id: @billing_address.id
      end

      it { should redirect_to root_path }
    end
  end

  context "PATCH #update" do 
    context 'being signed in' do
      before do
        sign_in @user
      end

      it "render 'edit' if billing_address is invalid" do
        patch :update, id: @billing_address.id, billing_address: attributes_for(:invalid_address) 
        response.should render_template :edit
      end

      it "redirects to edit_shipping_address_path if billing_address is valid" do
        patch :update, id: @billing_address.id, billing_address: attributes_for(:billing_address)
        response.should redirect_to edit_shipping_address_path
      end

      it "redirects to edit_delivery_path if shipping true" do
        patch :update, id: @billing_address.id, billing_address: attributes_for(:shipping_true)
        response.should redirect_to edit_delivery_path
      end
    end

    context 'being not signed in' do
      before do
        patch :update, id: @billing_address.id, billing_address: attributes_for(:billing_address)
      end

      it { should redirect_to new_user_session_path }
    end

    context 'cancan doesnt allow :update' do
      before do
        sign_in @user
        @ability.cannot :update, BillingAddress
        patch :update, id: @billing_address.id, billing_address: attributes_for(:billing_address)
      end

      it { should redirect_to root_path }
    end
  end
end