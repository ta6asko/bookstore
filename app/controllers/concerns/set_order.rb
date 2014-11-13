module SetOrder
  extend ActiveSupport::Concern
  
  private

    def set_order
      if current_user.orders.any?
        @order = current_user.orders.where(progress_id: '1') 
        current_user.orders.create unless @order
      else
        @order = current_user.orders.create
      end
    end

end