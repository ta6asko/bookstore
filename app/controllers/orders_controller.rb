class OrdersController < ApplicationController
  # load_and_authorize_resource
  include CurrentOrder
  include SetAddress
  
  before_action :destroy_line_items, only: [:destroy]
  after_action :up_order, only: [:complete]

  def index
    @in_progress = Order.find(session[:cart_id])
    @in_queue = current_user.orders.where(progress: 'in_queue')
    @in_delivery = current_user.orders.where(progress: 'in_delivery')
    @delivered = current_user.orders.where(progress: 'delivered')
  end

  def show
    @order = current_user.orders.find(params[:id])
    @status = @order.set_progress(@order.progress)
  end

  def cart
    @order = Order.find(session[:cart_id])
  end

  def confirm
    @order = Order.find(session[:cart_id])
  end

  def complete
    @order = current_user.orders.last
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