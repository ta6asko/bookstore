class BillingAddressesController < ApplicationController
  before_action :check_auth

  def index
    @billing_addresses = BillingAddress.all
    
  end

  def show

  end

  def new
    @cart = Cart.find(session[:cart_id])
    @billing_address = BillingAddress.new
    @shipping_address = ShippingAddress.new
  end

  def edit
    @cart = Cart.find(session[:cart_id])
    @billing_address = BillingAddress.new
    @delivery.update(billing_address_params)
  end

  def create
    @billing_address = BillingAddress.create(billing_address_params)
    if @billing_address.save
      if @billing_address.shipping == true
        @shipping_address = ShippingAddress.create(shipping_address_params)
        redirect_to new_delivery_path
      else
        redirect_to new_shipping_address_path
      end
    else
      render 'new'
    end 
  end

  def update
    @billing_address.update(billing_address_params)
  end

  def destroy
    @billing_address.destroy
  end

  def check_auth
    unless user_signed_in?
      redirect_to new_user_registration_path
    end
  end

  private
    def set_billing_address
      @billing_address = BillingAddress.find(params[:id])
    end

    def billing_address_params
      params[:billing_address].permit(:first_name, :last_name, :street_address, :city, :country_id, :zip, :phone, :shipping)
    end
    def shipping_address_params
      params[:billing_address].permit(:first_name, :last_name, :street_address, :city, :country_id, :zip, :phone)
    end
end
