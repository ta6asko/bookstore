class CartsController < ApplicationController

  include CurrentCart
  
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart
  
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
    respond_to do |format|
      format.html { redirect_to categories_path,
      notice: 'Теперь ваша корзина пуста!' }
      format.json { head :no_content }
    end
  end

  private

  def invalid_cart
    logger.error "Attempt to access invalid cart #{params[:id]}"
    redirect_to categories_path, notice: 'Invalid cart'
  end

end
