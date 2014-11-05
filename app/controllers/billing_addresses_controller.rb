class BillingAddressesController < ApplicationController
  before_action :check_auth

  def edit
    @user = current_user
    @billing_address = @user.billing_address
    @cart = Cart.find(session[:cart_id])
  end

  def update
    @user = current_user
    @billing_address = @user.billing_address
    if @billing_address.update(billing_address_params)
      if @billing_address.shipping == true
        @shipping_address = @user.shipping_address
        @shipping_address.update(shipping_address_params)
        redirect_to edit_delivery_path
      else
        edit_shipping_address_path
      end
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
