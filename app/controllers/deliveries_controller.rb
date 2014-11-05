class DeliveriesController < ApplicationController

  before_action :set_delivery, only: [:edit]

  def set_delivery
    if current_user.orders.any?
      @order = current_user.orders.where(progress_id: '1') 
      @order = current_user.orders.create if @order.count == 0
    else
      @order = current_user.orders.create
    end
  end

  def edit
    @deliveries = Delivery.all
    @cart = Cart.find(session[:cart_id])
    @order = current_user.orders.find_by(progress_id: '1')
  end

end
