class OrdersController < ApplicationController
  
  include CurrentOrder
  include SetAddress
  before_action :destroy_line_items, only: [:destroy]
  after_action :up_order, only: [:complete]


  def index
    @orders = current_user.orders
  end

  def show

  end

  def cart
    @order = Order.find(session[:cart_id])
  end

  def confirm
    @order = Order.find(session[:cart_id])
  end

  def complete
    @order = Order.find(session[:cart_id])
  end

  def update
    @order = Order.find(session[:cart_id])
    @order.update(params.require(:order).permit(:delivery_id))
    redirect_to edit_payment_path
  end

  def destroy
    redirect_to categories_path, notice: 'Теперь ваша корзина пуста!' 
  end

  def check_coupon  
    @order = Order.find(session[:cart_id])
    @coupon = Coupon.find_by(number: params[:search].to_i)
    if @coupon
      @order.discount += @coupon.discount
      @order.save
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