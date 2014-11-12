class DeliveriesController < ApplicationController
  include SetOrder
  
  before_action :set_order, only: [:edit]

  def edit
    @cart = Cart.find(session[:cart_id])
    @order = current_user.orders.find_by(progress_id: '1')
  end

end
