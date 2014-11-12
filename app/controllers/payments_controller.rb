class PaymentsController < ApplicationController 

  before_action :set_payment, only: [:edit]

  def set_payment
    @order = current_user.orders.find_by(progress_id: '1')
    @order.create_payment if @order.payment == nil
  end

  def edit 
    @cart = Cart.find(session[:cart_id])
    @order = current_user.orders.find_by(progress_id: '1')
  end

  def update
    @order = current_user.orders.find_by(progress_id: '1')
    @payment = @order.payment.update(payment_params)
    redirect_to confirm_orders_path
  end

  private

    def payment_params
      params.require(:payment).permit(:number, :card_code, :expiration_date)
    end
end
