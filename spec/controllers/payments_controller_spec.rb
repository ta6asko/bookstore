require 'controllers/controllers_spec_helper'

describe PaymentsController do
  before do
    @user = create(:user)
    @order = create(:order)
    allow(controller).to receive(:current_user) { @user }
    @payment = create(:payment)
    redefine_cancan_abilities
  end

  context "GET #edit" do
    context 'being signed in' do
      before do
        sign_in @user
        get :edit, id: @payment.id
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
        get :edit, id: @payment.id
      end

      it { should redirect_to new_user_session_path }
    end

    context 'cancan doesnt allow :edit' do
      before do
        sign_in @user
        @ability.cannot :edit, Payment
        get :edit, id: @payment.id
      end

      it { should redirect_to root_path }
    end
  end

  context "PATCH #update" do 
    context 'being signed in' do
      before do
        sign_in @user
      end

      it "render 'edit' if payment is invalid" do
        patch :update, id: @payment.id, payment: attributes_for(:invalid_payment) 
        response.should render_template :edit
      end

      it "redirects to confirm_orders_path if payment is valid" do
        patch :update, id: @payment.id, payment: attributes_for(:payment)
        response.should redirect_to confirm_orders_path
      end
    end

    context 'being not signed in' do
      before do
        patch :update, id: @payment.id, payment: attributes_for(:payment)
      end

      it { should redirect_to new_user_session_path }
    end

    context 'cancan doesnt allow :update' do
      before do
        sign_in @user
        @ability.cannot :update, Payment
        patch :update, id: @payment.id, payment: attributes_for(:payment)
      end

      it { should redirect_to root_path }
    end
  end
end