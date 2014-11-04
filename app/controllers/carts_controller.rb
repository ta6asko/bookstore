class CartsController < ApplicationController

  include CurrentCart
  include SetAddress
  
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  before_action :set_billing_address, only: [:set_cart_to_user]
  before_action :set_shipping_address, only: [:set_cart_to_user]
    
  def index
    @books = Book.all
    @cart = Cart.find(session[:cart_id])
  end

  def show
    @cart = Cart.find(session[:cart_id])
  end

  def destroy
    @cart = Cart.find(session[:cart_id])
    @cart.destroy if @cart.id == session[:cart_id]
    session[:cart_id] = nil
    redirect_to categories_path,
    notice: 'Теперь ваша корзина пуста!' 
  end

  def set_cart_to_user
    @cart = Cart.find(session[:cart_id])
    if @cart.id == session[:cart_id]
      render action: 'show'
    else
      @cart.id = session[:cart_id]
      render action: 'show' 
    end
  end

  private

  def invalid_cart
    logger.error "Attempt to access invalid cart #{params[:id]}"
    redirect_to categories_path, notice: 'Корзина пуста'
  end

end
