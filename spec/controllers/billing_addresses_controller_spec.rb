require 'rails_helper'

RSpec.describe BillingAddressesController, :type => :controller do

  before do
    @customer = create(:customer)
    @order = create(:order)
    allow(controller).to receive(:current_customer) { @customer }
    @address = create(:address)
    redefine_cancan_abilities
  end

  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all billing_addresses as @billing_addresses" do
      billing_address = BillingAddress.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:billing_addresses)).to eq([billing_address])
    end
  end

  describe "GET show" do
    it "assigns the requested billing_address as @billing_address" do
      billing_address = BillingAddress.create! valid_attributes
      get :show, {:id => billing_address.to_param}, valid_session
      expect(assigns(:billing_address)).to eq(billing_address)
    end
  end

  describe "GET new" do
    it "assigns a new billing_address as @billing_address" do
      get :new, {}, valid_session
      expect(assigns(:billing_address)).to be_a_new(BillingAddress)
    end
  end

  describe "GET edit" do
    it "assigns the requested billing_address as @billing_address" do
      billing_address = BillingAddress.create! valid_attributes
      get :edit, {:id => billing_address.to_param}, valid_session
      expect(assigns(:billing_address)).to eq(billing_address)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new BillingAddress" do
        expect {
          post :create, {:billing_address => valid_attributes}, valid_session
        }.to change(BillingAddress, :count).by(1)
      end

      it "assigns a newly created billing_address as @billing_address" do
        post :create, {:billing_address => valid_attributes}, valid_session
        expect(assigns(:billing_address)).to be_a(BillingAddress)
        expect(assigns(:billing_address)).to be_persisted
      end

      it "redirects to the created billing_address" do
        post :create, {:billing_address => valid_attributes}, valid_session
        expect(response).to redirect_to(BillingAddress.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved billing_address as @billing_address" do
        post :create, {:billing_address => invalid_attributes}, valid_session
        expect(assigns(:billing_address)).to be_a_new(BillingAddress)
      end

      it "re-renders the 'new' template" do
        post :create, {:billing_address => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested billing_address" do
        billing_address = BillingAddress.create! valid_attributes
        put :update, {:id => billing_address.to_param, :billing_address => new_attributes}, valid_session
        billing_address.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested billing_address as @billing_address" do
        billing_address = BillingAddress.create! valid_attributes
        put :update, {:id => billing_address.to_param, :billing_address => valid_attributes}, valid_session
        expect(assigns(:billing_address)).to eq(billing_address)
      end

      it "redirects to the billing_address" do
        billing_address = BillingAddress.create! valid_attributes
        put :update, {:id => billing_address.to_param, :billing_address => valid_attributes}, valid_session
        expect(response).to redirect_to(billing_address)
      end
    end

    describe "with invalid params" do
      it "assigns the billing_address as @billing_address" do
        billing_address = BillingAddress.create! valid_attributes
        put :update, {:id => billing_address.to_param, :billing_address => invalid_attributes}, valid_session
        expect(assigns(:billing_address)).to eq(billing_address)
      end

      it "re-renders the 'edit' template" do
        billing_address = BillingAddress.create! valid_attributes
        put :update, {:id => billing_address.to_param, :billing_address => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested billing_address" do
      billing_address = BillingAddress.create! valid_attributes
      expect {
        delete :destroy, {:id => billing_address.to_param}, valid_session
      }.to change(BillingAddress, :count).by(-1)
    end

    it "redirects to the billing_addresses list" do
      billing_address = BillingAddress.create! valid_attributes
      delete :destroy, {:id => billing_address.to_param}, valid_session
      expect(response).to redirect_to(billing_addresses_url)
    end
  end

end
require 'controllers/controllers_spec_helper'

describe AddressesController do
  before do
    @customer = create(:customer)
    @order = create(:order)
    allow(controller).to receive(:current_customer) { @customer }
    @address = create(:address)
    redefine_cancan_abilities
  end

  context "GET #new" do
    context 'being signed in' do
      before do
        sign_in @customer
        get :new
      end

      it "responds successfully with an HTTP 200 status code" do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "renders the new template" do
        expect(response).to render_template("new")
      end
    end

    context 'being not signed in' do
      before do
        get :new
      end

      it { should redirect_to new_customer_session_path }
    end

    context 'cancan doesnt allow :new' do
      before do
        sign_in @customer
        @ability.cannot :new, Address
        get :new
      end

      it { should redirect_to root_path }
    end
  end

  context "GET #edit" do
    context 'being signed in' do
      before (:each) do
        sign_in @customer
        get :edit, id: @address.id
      end

      it "responds successfully with an HTTP 200 status code" do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "renders the edit template" do
        expect(response).to render_template("edit")
      end
    end

    context 'being not signed in' do
      before do
        get :edit, id: @address.id
      end

      it { should redirect_to new_customer_session_path }
    end

    context 'cancan doesnt allow :edit' do
      before do
        sign_in @customer
        @ability.cannot :edit, Address
        get :edit, id: @address.id
      end

      it { should redirect_to root_path }
    end
  end

  context "POST create" do
    context 'being signed in' do
      before (:each) do
        sign_in @customer
      end
      
      it "redirects to the new_shipping_addresses_path if address is valid" do
        country = create(:country, name: 'England')
        post :create, address: attributes_for(:address, country_id: country.id)
        expect(response).to redirect_to(new_shipping_addresses_path)
      end

      it "re-renders the new template if address is invalid" do
        post :create, address: attributes_for(:invalid_address) 
        response.should render_template :new
      end
    end

    context 'being not signed in' do
      before do
        post :create, address: attributes_for(:address) 
      end

      it { should redirect_to new_customer_session_path }
    end

    context 'cancan doesnt allow :create' do
      before do
        sign_in @customer
        @ability.cannot :create, Address
        post :create, address: attributes_for(:address) 
      end

      it { should redirect_to root_path }
    end
  end

  context "PATCH update" do 
    context 'being signed in' do
      before (:each) do
        sign_in @customer
      end

      it "re-renders the edit template if address is invalid" do
        patch :update, id: @address.id, address: attributes_for(:invalid_address) 
        response.should render_template :edit
      end

      it "redirects to the order_confirm_path if address is valid" do
        patch :update, id: @address.id, address: attributes_for(:address, address: "Street")
        orders = Order.all
        order = orders[1] 
        response.should redirect_to order_confirm_path(order) 
      end
    end

    context 'being not signed in' do
      before do
        patch :update, id: @address.id, address: attributes_for(:address, address: "Street")
      end

      it { should redirect_to new_customer_session_path }
    end

    context 'cancan doesnt allow :update' do
      before do
        sign_in @customer
        @ability.cannot :update, Address
        patch :update, id: @address.id, address: attributes_for(:address, address: "Street")
      end

      it { should redirect_to root_path }
    end
  end
end