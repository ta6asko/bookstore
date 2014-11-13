class UsersController < ApplicationController
  
  include SetAddress
  include CurrentCart

  before_action :set_cart, only: [:show]
  before_action :set_address, only: [:settings_update_billing_address]
  before_action :set_address, only: [:settings_update_shipping_address]
  
  def show
    @user = User.find(current_user.id)
    @cart = Cart.find(session[:cart_id])
  end

  def settings_update_billing_address
    if current_user.billing_address.update(billing_address_params)
      redirect_to user_path(current_user), notice: "Saved" 
    end
    logger.error "Not saved"
  end

  def settings_update_shipping_address
    if current_user.shipping_address.update(shipping_address_params)
      redirect_to user_path(current_user), notice: "Saved" 
    end
    logger.error "Not saved"
  end

  def update_email
    @user = User.find(current_user.id)
    current_user.update(user_params)
    redirect_to user_path(current_user), notice: "Saved" if @user.save
  end

  def update_password
    @user = User.find(current_user.id)
    if @user.update_with_password(user_params)
      sign_in @user, :bypass => true  
      redirect_to root_path
    else
      render "show"
    end
  end

  private

  def user_params
    params.required(:user).permit(:password, :current_password)
  end

end
