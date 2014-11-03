class PaymentsController < ApplicationController

  def new
    @cart = Cart.find(session[:cart_id])
    @payment = Payment.new
  end

  def edit
    @payment = Payment.find(params[:id])
  end

  def create
    @payment = Payment.new
    if @payment = @payment.update(payment_params)
      redirect_to confirm_orders_path
    else
      rander "new"
    end
  end

  def update
    @payment = Payment.find(params[:id])
    @payment.update(payment_params)
    redirect_to confirm_orders_path
  end

  private

    def payment_params
      params.require(:payment).permit(:number, :card_code, :expiration_date)
    end
end
