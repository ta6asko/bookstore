class OrdersController < ApplicationController
  include CurrentCart

  before_action :up_order, only: [:complete]
  after_action :destroy_cart, only: [:complete]
  before_action :set_cart, only: [:index]

  def index
    @cart = Cart.find(session[:cart_id])
    @shipping_address = current_user.shipping_address
    @billing_address = current_user.billing_address
    # @order = current_user.orders.find_by(progress_id: '1')
    # @payment = @order.payment
    # @delivery_name = @order.delivery.name
    # @delivery_price = @order.delivery.price
    # @country = Country.all
    # # @country_billing = @country.billing_address.find(params[:country_id])
    # # @country_shipping = @shipping_address.country.name
    # @numb = @payment.number.to_s.slice(-6..-3)
    # @order_total = (@cart.total_price)+(@delivery_price)
  end

  def confirm
    @cart = Cart.find(session[:cart_id])
    @shipping_address = current_user.shipping_address
    @billing_address = current_user.billing_address
    @order = current_user.orders.find_by(progress_id: '1')
    @payment = @order.payment
    @delivery_name = @order.delivery.name
    @delivery_price = @order.delivery.price
    @country = Country.all
    # @country_billing = @country.billing_address.find(params[:country_id])
    # @country_shipping = @shipping_address.country.name
    @numb = @payment.number.to_s.slice(-6..-3)
    @order_total = (@cart.total_price)+(@delivery_price)
  end

  def complete
    @cart = Cart.find(session[:cart_id])
    @shipping_address = current_user.shipping_address
    @billing_address = current_user.billing_address
    @order = current_user.orders.last
    @payment = @order.payment
    @delivery_name = @order.delivery.name
    @delivery_price = @order.delivery.price
    @country = Country.all
    # @country_billing = @country.billing_address.find(params[:country_id])
    # @country_shipping = @shipping_address.country.name
    @numb = @payment.number.to_s.slice(-6..-3)
    @order_total = (@cart.total_price)+(@delivery_price)
  end

  def settings_update_billing_address
    @billing_address = current_user.billing_address
    if @billing_address.update(billing_address_params)
      render :nothing
    end 
  end

  def settings_update_shipping_address
    @shipping_address = current_user.shipping_address
    if @shipping_address.update(shipping_address_params)
      render :nothing
    end 
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

  private 

  def shipping_address_params
    params[:shipping_address].permit(:first_name, :last_name, :street_address, :city, :country_id, :zip, :phone)
  end

end
