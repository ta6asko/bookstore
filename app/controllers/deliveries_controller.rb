class DeliveriesController < ApplicationController
  
  include SetOrder
  
  before_action :set_order, only: [:set_delivery]

  def set_delivery
    @order = Order.new
    @deliveries = Delivery.all
    @cart = Cart.find(session[:cart_id])
  end

  def new
    @order = Order.new
    @deliveries = Delivery.all
    @cart = Cart.find(session[:cart_id])
  end

  def edit
    @order = Order.find(params[:id])
    @deliveries = Delivery.all
  end

  def create
    @order = Order.new
    @order.update(order_params)
    redirect_to new_payment_path
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to confirm_orders_path
  end

  private

  def order_params
    params.require(:order).permit(:delivery_id)
  end
end
