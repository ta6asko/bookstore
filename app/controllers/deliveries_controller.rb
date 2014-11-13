class DeliveriesController < ApplicationController
  include CurrentOrder
  
  before_action :set_order, only: [:edit]

  def edit
    @order = Order.find(session[:cart_id])
  end

end
