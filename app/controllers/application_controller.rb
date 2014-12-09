class ApplicationController < ActionController::Base

  include CurrentOrder

  rescue_from CanCan::AccessDenied do 
    redirect_to root_url
  end
  
  before_action :set_order
  
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller? 
  after_filter :store_location

def store_location
  # store last url as long as it isn't a /users path
  session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users/
end

def after_sign_in_path_for(user)
  session[:previous_url] || root_path
end

def configure_permitted_parameters
  devise_parameter_sanitizer.for(:account_update) { |u| 
    u.permit(:password, :password_confirmation, :current_password) 
  }
end

end
