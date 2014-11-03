class BillingAddressesController < ApplicationController
  before_action :check_auth

  def new
    @billing_address = current_user.billingaddress.new
    @shipping_address = ShippingAddress.new
    @cart = Cart.find(session[:cart_id])
  end

  def edit
    @billing_address = BillingAddress.find(params[:id])
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
    @billing_address = BillingAddress.find(params[:id])
    if @billing_address.update(billing_address_params)
      redirect_to edit_shipping_address_path
    else
      render 'edit'
    end 
  end

  def check_auth
    unless user_signed_in?
      redirect_to new_user_registration_path
    end
  end

  private

    def billing_address_params
      params[:billing_address].permit(:first_name, :last_name, :street_address, :city, :country_id, :zip, :phone, :shipping)
    end
    def shipping_address_params
      params[:billing_address].permit(:first_name, :last_name, :street_address, :city, :country_id, :zip, :phone)
    end
end
