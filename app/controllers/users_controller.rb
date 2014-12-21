class UsersController < ApplicationController
  
  # load_and_authorize_resource

  before_action :set_user, only: [:edit, :update_password, :destroy_user]
  # before_action :authenticate_user!
  
  def edit
  end

  def settings_update_billing_address
    if current_user.billing_address.update(billing_address_params)
      redirect_to edit_user_path(current_user), notice: "Billing address has successfully changed" 
    else
      redirect_to edit_user_path(current_user), notice: "fail"
    end
  end

  def settings_update_shipping_address
    if current_user.shipping_address.update(shipping_address_params)
      redirect_to edit_user_path(current_user), notice: "Shipping address has successfully changed" 
    else
      redirect_to edit_user_path(current_user), notice: "fail"
    end
  end

  def update_email
    if current_user.update(user_params)
      redirect_to edit_user_path(current_user), notice: "Email has successfully changed" 
    end
  end

  def update_password
    if @user.update_with_password(user_params)
      sign_in @user, :bypass => true  
      redirect_to edit_user_path(current_user), notice: "Password has successfully changed" 
    else
      redirect_to edit_user_path(current_user), notice: "fail"
    end
  end

  def destroy_user
    @user.update(params[:user].permit(:check_del))
    if @user.check_del
      @user.destroy
      sign_out @user
      redirect_to categories_path, notice: "Account has removed" 
    else
      redirect_to edit_user_path(current_user), notice: "fail"
    end
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

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
