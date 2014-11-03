class OrdersController < ApplicationController
  include CurrentCart

  def index
    @billing_address = BillingAddress.first
    @shipping_address = ShippingAddress.first
  end

  def confirm
    @cart = Cart.find(session[:cart_id])
    @shipping_address = ShippingAddress.first
    @billing_address = BillingAddress.first
    @payment = Payment.first
    @order = Order.first
    @delivery_name = @order.delivery.name
    @delivery_price = @order.delivery.price
    @country_sh = @shipping_address.country.name
    @country_b = @shipping_address.country.name
    @numb = @payment.number.to_s.length <= 4 ? number : @payment.number.to_s.slice(-6..-3)
    @order_total = (@cart.total_price)+(@delivery_price)
  end

  def complete
    @cart = Cart.find(session[:cart_id])
    @shipping_address = ShippingAddress.first
    @billing_address = BillingAddress.first
    @payment = Payment.first
    @order = Order.first
    @delivery_name = @order.delivery.name
    @delivery_price = @order.delivery.price
    @country_sh = @shipping_address.country.name
    @country_b = @shipping_address.country.name
    @numb = @payment.number.to_s.length <= 4 ? number : @payment.number.to_s.slice(-6..-3)
    @order_total = (@cart.total_price)+(@delivery_price)
  end

  private 

  def shipping_address_params
    params[:shipping_address].permit(:first_name, :last_name, :street_address, :city, :country_id, :zip, :phone)
  end

end
