module CurrentCart
  extend ActiveSupport::Concern

  private

    def set_cart
      @cart = Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end

    def destroy_cart
      @cart = Cart.find(session[:cart_id])
      @cart.destroy if @cart.id == session[:cart_id]
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end
end