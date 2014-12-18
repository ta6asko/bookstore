class PaymentsController < ApplicationController 
 
  load_and_authorize_resource
  before_action :authenticate_user!
  
  def edit 
  end

  def update
    if current_user.payment.update(payment_params)
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
