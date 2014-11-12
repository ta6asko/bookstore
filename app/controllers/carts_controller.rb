class CartsController < ApplicationController

  include SetAddress
  before_action :set_address, only: [:show]
  before_action :destroy_line_items, only: [:destroy]

  def show
    @cart = Cart.find(session[:cart_id])
  end

  def destroy
    redirect_to categories_path, notice: 'Теперь ваша корзина пуста!' 
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
