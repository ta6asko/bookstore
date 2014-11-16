class DeliveriesController < ApplicationController
  include CurrentOrder
  
  before_action :set_order, only: [:edit]

  def edit
    @cart = Order.find(session[:cart_id])
  end

end
