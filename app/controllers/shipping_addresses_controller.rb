class ShippingAddressesController < ApplicationController

  def edit
    @cart = Order.find(session[:cart_id])
  end

  def update
    if current_user.shipping_address.update(shipping_address_params)
      redirect_to edit_delivery_path
    else
      render 'edit'
    end 
  end

  private

    def shipping_address_params
      params[:shipping_address].permit(:first_name, :last_name, :street_address, :city, :country_id, :zip, :phone)
    end

end
