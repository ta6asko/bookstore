class PaymentsController < ApplicationController

  def new
    @cart = Cart.find(session[:cart_id])
    @payment = Payment.new
  end

  def edit
    @delivery.update(delivery_params)
  end

  def create
    @payment = Payment.new
    @payment = @payment.update(payment_params)
    redirect_to confirm_orders_path
  end

  def update
    @payment.update(payment_params)
  end

  private

    def payment_params
      params.require(:payment).permit(:number, :card_code, :expiration_date)
    end
end
