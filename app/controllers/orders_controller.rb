class OrdersController < ApplicationController
  
  include CurrentCart
  include SetOrder

  before_action :up_order, only: [:complete]
  after_action :destroy_line_items, only: [:complete]

  def confirm
    @cart = Cart.find(session[:cart_id])
    @order = current_user.orders.find_by(progress_id: '1')
  end

  def complete
    @cart = Cart.find(session[:cart_id])
    @order = current_user.orders.last
  end

  def update
    @order = current_user.orders.find_by(progress_id: '1')
    @order.update(params.require(:order).permit(:delivery_id))
    redirect_to edit_payment_path
  end

  def up_order
    @order = current_user.orders.last
    @order.progress_id = 2
  end

  private 

  def shipping_address_params
    params[:shipping_address].permit(:first_name, :last_name, :street_address, :city, :country_id, :zip, :phone)
  end

  def billing_address_params
    params[:billing_address].permit(:first_name, :last_name, :street_address, :city, :country_id, :zip, :phone)
  end
end
