class CartsController < ApplicationController

  include CurrentCart
  include SetAddress
  
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  before_action :set_billing_address, only: [:set_cart_to_user]
  before_action :set_shipping_address, only: [:set_cart_to_user]
  before_action :destroy_line_items, only: [:destroy]
  
    
  def index
    @books = Book.all
    @cart = Cart.find(session[:cart_id])
  end

  def show
    @cart = Cart.find(session[:cart_id])

  end

  def destroy
    redirect_to categories_path, notice: 'Теперь ваша корзина пуста!' 
  end

  def set_cart_to_user
    @cart = Cart.find(session[:cart_id])
    session[:cart_id] = @cart.id unless @cart.id == session[:cart_id]
    render action: 'show' 
  end

  def check_coupon  
    @cart = Cart.find(session[:cart_id])
    @coupon = Coupon.find_by(number: params[:search].to_i)
    if @coupon
      @cart.discount += @coupon.discount
      @cart.save
      @coupon.destroy
      redirect_to cart_path(@cart), notice: "You coupon has successfully"
    else
      redirect_to cart_path(@cart), notice: "Invalid coupon number"
    end
  end

  private

  def invalid_cart
    logger.error "Attempt to access invalid cart #{params[:id]}"
    redirect_to categories_path, notice: 'Корзина пуста'
  end

end
