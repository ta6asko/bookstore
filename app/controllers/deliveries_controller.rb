class DeliveriesController < ApplicationController
  include CurrentOrder
  # load_and_authorize_resource
  before_action :set_order, only: [:edit]

  def edit
    @cart = Order.find(session[:cart_id])
  end

end
