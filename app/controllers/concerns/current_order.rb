module CurrentOrder
  extend ActiveSupport::Concern

  private

    def set_order
      @order = Order.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      @order = Order.create
      session[:cart_id] = @order.id
    end

    def up_order
      @order = Order.find(session[:cart_id])
      @order.progress = 'in_queue'
      session[:cart_id] = nil
    end

    def destroy_line_items
      @order = Order.find(session[:cart_id])
      @order.line_items.destroy_all
    end
end