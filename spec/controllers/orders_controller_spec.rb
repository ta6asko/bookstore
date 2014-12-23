require 'controllers/controllers_spec_helper'

describe OrdersController do

  before do
    @user = create(:user)
    @order = create(:order, user_id: @user.id)
    @delivery = create(:delivery)
    @line_item = create(:line_item)
    allow(controller).to receive(:current_user) { @user }
    redefine_cancan_abilities
  end

  context "GET #index" do
    context 'being signed in' do
      before do
        sign_in @user
        get :index, id: @order.id
      end

      it "responds successfully with an HTTP 200 status code" do
        expect(response.status).to eq(200)
      end

      it "renders the index template" do
        expect(response).to render_template("index")
      end
    end

    context 'being not signed in' do
      before do
        get :index, id: @order.id
      end

      it { should redirect_to new_user_session_path }
    end

    context 'cancan doesnt allow :index' do
      before do
        sign_in @user
        @ability.cannot :index, Order
        get :index
      end

      it { should redirect_to root_path }
    end
  end

  context "GET #show" do
    context 'being signed in' do
      before do
        sign_in @user
        get :show, id: @order.id
      end

      it "responds successfully with an HTTP 200 status code" do
        expect(response.status).to eq(200)
      end

      it "renders the show template" do
        expect(response).to render_template("show")
      end
    end

    context 'being not signed in' do
      before do
        get :show, id: @order.id
      end

      it { should redirect_to new_user_session_path }
    end

    context 'cancan doesnt allow :show' do
      before do
        sign_in @user
        @ability.cannot :show, Order
        get :show, id: @order.id
      end

      it { should redirect_to root_path }
    end
  end

  context "PATCH #update" do 
    context 'being signed in' do
      before do
        sign_in @user
      end

      it "redirects to edit_payment_path" do
        patch :update, id: @order.id, order: attributes_for(:delivery_id)
        response.should redirect_to edit_payment_path
      end
    end

    context 'being not signed in' do
      before do
        patch :update, id: @order.id, order: attributes_for(:order)
      end

      it { should redirect_to new_user_session_path }
    end

    context 'cancan doesnt allow :update' do
      before do
        sign_in @user
        @ability.cannot :update, Order
        patch :update, id: @order.id, order: attributes_for(:order)
      end

      it { should redirect_to root_path }
    end
  end

  context "GET #cart" do
    before do
      get :cart, id: @order.id
    end

    it "responds successfully with an HTTP 200 status code" do
      expect(response.status).to eq(200)
    end

    it "renders the cart template" do
      expect(response).to render_template("cart")
    end
  end

  context "GET #confirm" do
    context 'being signed in' do
      before do
        sign_in @user
        get :confirm, id: @order.id
      end

      it "responds successfully with an HTTP 200 status code" do
        expect(response.status).to eq(200)
      end

      it "renders the confirm template" do
        expect(response).to render_template("confirm")
      end
    end

    context 'being not signed in' do
      before do
        get :confirm, id: @order.id
      end

      it { should redirect_to new_user_session_path }
    end

    context 'cancan doesnt allow :confirm' do
      before do
        sign_in @user
        @ability.cannot :confirm, Order
        get :confirm, id: @order.id
      end

      it { should redirect_to root_path }
    end
  end

  context "GET #complete" do
    context 'being signed in' do
      before do
        sign_in @user
        get :complete, id: @order.id
      end

      it "responds successfully with an HTTP 200 status code" do
        expect(response.status).to eq(200)
      end

      it "renders the complete template" do
        expect(response).to render_template("complete")
      end
    end

    context 'being not signed in' do
      before do
        get :complete, id: @order.id
      end

      it { should redirect_to new_user_session_path }
    end
    
    context 'cancan doesnt allow :confirm' do
      before do
        sign_in @user
        @ability.cannot :confirm, Order
        get :confirm, order_id: @order.id
      end

      it { should redirect_to root_path }
    end
  end

  context "GET #empty_cart" do 
    before do
      get :empty_cart, id: @order.id
    end

    it "redirects to categories_path" do
      response.should redirect_to categories_path
    end
  end

  context "GET #check_coupon" do 
    before do
      get :check_coupon, id: @order.id
    end

    it "redirects to cart_orders_path if coupon valid" do
      @coupon = create(:coupon)
      response.should redirect_to cart_orders_path
      expect(flash[:notice]).to eq "You coupon has successfully"
    end

    it "redirects to cart_orders_path if coupon invalid" do
      @coupon = create(:coupon)
      response.should redirect_to cart_orders_path
      expect(flash[:notice]).to eq "Invalid coupon number"
    end
  end
  
end