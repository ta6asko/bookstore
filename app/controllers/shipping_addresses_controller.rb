class ShippingAddressesController < ApplicationController


  def new
    @shipping_address = ShippingAddress.new
    @cart = Cart.find(session[:cart_id])
  end

  def edit
    @delivery.update(delivery_params)
  end

  def create
    @shipping_address = ShippingAddress.create(shipping_address_params)
    if @shipping_address.save
      redirect_to new_delivery_path
    else
      render 'new'
    end
  end

  def update
    @shipping_address.update(shipping_address_params)
  end

  private

    def shipping_address_params
      params[:shipping_address].permit(:first_name, :last_name, :street_address, :city, :country_id, :zip, :phone)
    end

end
