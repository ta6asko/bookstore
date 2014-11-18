class BillingAddressesController < ApplicationController
  
  # load_and_authorize_resource
  include SetAddress
    
  before_action :set_address, only: [:edit]
  before_action :authenticate_user!

  def edit
    @cart = Order.find(session[:cart_id])
  end

  def update
    @cart = Order.find(session[:cart_id])
    if current_user.billing_address.update(billing_address_params)
      if current_user.billing_address.shipping == true
        current_user.shipping_address.update(shipping_address_params)
        current_user.billing_address.shipping = false
        current_user.billing_address.save
        redirect_to edit_delivery_path
      else
        redirect_to edit_shipping_address_path
      end
    else
      render 'edit'
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
