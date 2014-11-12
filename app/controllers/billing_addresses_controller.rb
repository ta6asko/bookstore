class BillingAddressesController < ApplicationController
  before_action :check_auth

  def edit
    @cart = Cart.find(session[:cart_id])
  end

  def update
    if current_user.billing_address.update(billing_address_params)
      if current_user.billing_address.shipping == true
        current_user.shipping_address.update(shipping_address_params)
        redirect_to edit_delivery_path
      else
        redirect_to edit_shipping_address_path(current_user)
      end
    else
      render 'edit'
    end 
  end

  def check_auth
    redirect_to new_user_registration_path unless user_signed_in?
  end

  private

    def billing_address_params
      params[:billing_address].permit(:first_name, :last_name, :street_address, :city, :country_id, :zip, :phone, :shipping)
    end
    def shipping_address_params
      params[:billing_address].permit(:first_name, :last_name, :street_address, :city, :country_id, :zip, :phone)
    end
end
