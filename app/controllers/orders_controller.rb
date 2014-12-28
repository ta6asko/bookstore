class OrdersController < ApplicationController
  
  load_and_authorize_resource
  before_action :set_order, skip: [:show]
  
  after_action :up_order, only: [:complete]
  before_action :authenticate_user!, only: [:index, :show, :update, :confirm, :complete]

  def index
    @in_queue = current_user.orders.where(progress: 'in_queue')
    @in_delivery = current_user.orders.where(progress: 'in_delivery')
    @delivered = current_user.orders.where(progress: 'delivered')
  end

  def show
    @order = Order.find(params[:id])
    @status = @order.set_progress(@order.progress)
  end

  def update
    @order.update(order_params)
    redirect_to edit_payment_path
  end

  def cart

  end

  def confirm
    @shipping_address = current_user.shipping_address
  end

  def complete
    @order.user_id = current_user.id 
    @order.save
  end

  def empty_cart
    @order.line_items.destroy_all
    redirect_to categories_path, notice: 'Теперь ваша корзина пуста!'
  end

  def check_coupon  
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

  def order_params
    params.require(:order).permit(:delivery_id)
  end

  def invalid_cart
    logger.error "Attempt to access invalid cart #{params[:id]}"
    redirect_to categories_path, notice: 'Корзина пуста'
  end

end