class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

   def after_sign_in_path_for(resource)
    set_cart_to_user_carts_path
  end
end
