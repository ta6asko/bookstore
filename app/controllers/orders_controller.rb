class OrdersController < ApplicationController
  
  include CurrentOrder
  include SetOrder
  include SetAddress
  before_action :set_address, only: [:show]
  before_action :destroy_line_items, only: [:destroy]
  before_action :up_order, only: [:complete]
  after_action :destroy_line_items, only: [:complete]

  def index
    @cart = Cart.find(session[:cart_id])
    @orders = current_user.orders.find_by(progress_id: '1')
  end

  def show

  end

  def cart
    @cart = Order.find(session[:cart_id])
  end

  def confirm
    @cart = Cart.find(session[:cart_id])
    @order = current_user.orders.find_by(progress_id: '1')
  end

  def complete
    @cart = Cart.find(session[:cart_id])
    @order = current_user.orders.last
  end

  def update
    @order = current_user.orders.find_by(progress_id: '1')
    @order.update(params.require(:order).permit(:delivery_id))
    redirect_to edit_payment_path
  end

  def up_order
    @order = current_user.orders.last
    @order.progress_id = 2
  end

  def destroy
    redirect_to categories_path, notice: 'Теперь ваша корзина пуста!' 
  end

  def check_coupon  
    @cart = Order.find(session[:cart_id])
    @coupon = Coupon.find_by(number: params[:search].to_i)
    if @coupon
      @cart.discount += @coupon.discount
      @cart.save
      @coupon.destroy
      redirect_to cart_orders_path, notice: "You coupon has successfully"
    else
      redirect_to cart_orders_path, notice: "Invalid coupon number"
    end
  end

  private

  def invalid_cart
    logger.error "Attempt to access invalid cart #{params[:id]}"
    redirect_to categories_path, notice: 'Корзина пуста'
  end

end