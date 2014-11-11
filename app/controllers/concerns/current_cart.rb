module CurrentCart
  extend ActiveSupport::Concern

  private

    def set_cart
      @cart = Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end

    def destroy_line_items
      @cart = Cart.find(session[:cart_id])
      @cart.line_items.destroy_all
      @cart.discount = 0
      @cart.save
    end
end