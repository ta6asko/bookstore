class UsersController < ApplicationController
  
  include SetAddress
  include CurrentOrder

  before_action :set_order, only: [:show]
  before_action :set_address, only: [:settings_update_billing_address, :settings_update_shipping_address, :show]

  
  def show
    @user = User.find(current_user.id)
    @cart = Order.find(session[:cart_id])
  end

  def settings_update_billing_address
    if current_user.billing_address.update(billing_address_params)
      redirect_to user_path(current_user), notice: "Billing address has successfully changed" 
    end
    logger.error "Not saved"
  end

  def settings_update_shipping_address
    if current_user.shipping_address.update(shipping_address_params)
      redirect_to user_path(current_user), notice: "Shipping address has successfully changed" 
    end
    logger.error "Not saved"
  end

  def update_email
    current_user.update(user_params)
    redirect_to user_path(current_user), notice: "Email has successfully changed" if @user.save
  end

  def update_password
    @user = User.find(current_user.id)
    if @user.update_with_password(user_params)
      sign_in @user, :bypass => true  
      redirect_to user_path(current_user), notice: "Password has successfully changed" 
    else
      render "show"
    end
  end

  def destroy_user
    @user = User.find(current_user.id)
    @user.update(params[:user].permit(:check_del))
    if @user.check_del
      @user.destroy
      sign_out @user
      redirect_to categories_path
    else
      redirect_to user_path(current_user), notice: "fail"
    end
  end

  private

  def user_params
    params.required(:user).permit(:password, :current_password)
  end 

  def shipping_address_params
    params[:shipping_address].permit(:first_name, :last_name, :street_address, :city, :country_id, :zip, :phone)
  end

  def billing_address_params
    params[:billing_address].permit(:first_name, :last_name, :street_address, :city, :country_id, :zip, :phone)
  end

end
