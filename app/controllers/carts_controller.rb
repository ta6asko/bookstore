class CartsController < ApplicationController
  include CurrentCart
  
  def index
    @books = Book.all
    @cart = Cart.find(session[:cart_id])

  end

  def show

  end

end
