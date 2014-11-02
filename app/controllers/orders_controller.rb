class OrdersController < ApplicationController
  include CurrentCart

  def index

  end
  
  def create 
    
  end

  def confirm
    @cart = Cart.find(session[:cart_id])
    @shipping_address = ShippingAddress.first
    @billing_address = BillingAddress.first
  end

  def complete
    @cart = Cart.find(session[:cart_id])
  end

  private 

  def shipping_address_params
    params[:shipping_address].permit(:first_name, :last_name, :street_address, :city, :country_id, :zip, :phone)
  end

end
