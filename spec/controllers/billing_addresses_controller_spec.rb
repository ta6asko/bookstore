require 'controllers/controllers_spec_helper'

describe BillingAddressesController do
  before do
    @user = create(:user)
    @order = create(:order)
    allow(controller).to receive(:current_user) { @user }
    @billing_address = create(:billing_address)
    redefine_cancan_abilities
  end

  context "GET #edit" do
    context 'cancan doesnt allow :edit' do
      before do
        sign_in @user
        @ability.cannot :edit, Address
        get :edit, id: @billing_address.id
      end

      it { should redirect_to root_path }
    end
  end

  context "PATCH #update" do 
    context 'being signed in' do
      before (:each) do
        sign_in @user
      end

      it "render 'edit' if billing_address is invalid" do
        patch :update, id: @billing_address.id, billing_address: attributes_for(:invalid_address) 
        response.should render_template :edit
      end

      it "redirects to edit_shipping_address_path if billing_address is valid" do
        patch :update, id: @billing_address.id, billing_address: attributes_for(:billing_address, billing_address: "Street")
        orders = Order.all
        order = orders[1] 
        response.should redirect_to order_confirm_path(order) 
      end
    end

    context 'cancan doesnt allow :update' do
      before do
        sign_in @customer
        @ability.cannot :update, Address
        patch :update, id: @billing_address.id, billing_address: attributes_for(:billing_address, billing_address: "Street")
      end

      it { should redirect_to root_path }
    end
  end
end