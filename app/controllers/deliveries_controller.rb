class DeliveriesController < ApplicationController
  before_action :set_delivery, only: [:show, :edit, :update, :destroy]

  def index
    @deliveries = Delivery.all

  end

  def show

  end

  def new
    @order = Order.new
    @deliveries = Delivery.all
    @cart = Cart.find(session[:cart_id])
  end

  def edit
    @cart = Cart.find(session[:cart_id])
  end

  def create
    @order = Order.new
    @order.update(order_params)
    redirect_to new_payment_path
  end

  def update
    @delivery.update(delivery_params)
  end

  def destroy
    @delivery.destroy
 
  end

  private
    def set_delivery
      @delivery = Delivery.find(params[:id])
    end

    def delivery_params
      params[:delivery]
    end

  def order_params
    params.require(:order).permit(:delivery_id)
  end
end
