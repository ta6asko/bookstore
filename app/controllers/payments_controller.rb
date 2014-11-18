class PaymentsController < ApplicationController 
  # load_and_authorize_resource
  include CurrentOrder


  before_action :set_order, only: [:edit]
  before_action :set_payment, only: [:edit]

  def set_payment
    @order = Order.find(session[:cart_id])
    @order.create_payment if @order.payment == nil
  end

  def edit 
    @cart = Order.find(session[:cart_id])
  end

  def update
    @order = Order.find(session[:cart_id])
    if @order.payment.update(payment_params)
      redirect_to confirm_orders_path
    else
      render "edit"
    end
  end

  private

    def payment_params
      params.require(:payment).permit(:number, :card_code, :expiration_date)
    end
end
