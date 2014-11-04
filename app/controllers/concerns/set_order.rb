module SetOrder
  extend ActiveSupport::Concern

  private

    def set_order
      @order = current_user.oder
      if @order == nil
        @order = current_user.order.create
      end
    end
end