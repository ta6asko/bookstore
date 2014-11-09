class CartsController < ApplicationController

  include CurrentCart
  include SetAddress
  
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  before_action :set_billing_address, only: [:set_cart_to_user]
  before_action :set_shipping_address, only: [:set_cart_to_user]
  before_action :destroy_cart, only: [:destroy]
  
    
  def index
    @books = Book.all
    @cart = Cart.find(session[:cart_id])
  end

  def show
    @cart = Cart.find(session[:cart_id])
  end

  def destroy
    redirect_to categories_path,
    notice: 'Теперь ваша корзина пуста!' 
  end

  def set_cart_to_user
    @cart = Cart.find(session[:cart_id])
    if @cart.id == session[:cart_id]
      render action: 'show'
    else
      session[:cart_id] = @cart.id
      render action: 'show' 
    end
  end

  private

  def invalid_cart
    logger.error "Attempt to access invalid cart #{params[:id]}"
    redirect_to categories_path, notice: 'Корзина пуста'
  end

end
