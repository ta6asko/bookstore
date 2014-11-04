module SetAddress
  extend ActiveSupport::Concern

  private

    def set_progress_by_id
      @order = current_user.order.find
      @progress_id = @order.progress_id
      if @progress_id == 1
        @progress = in_progress
      elsif @progress_id == 2
        @progress = in_queue
      elsif @progress_id == 3
        @progress = in_delivery 
      elsif @progress_id == 4
        @progress = delivered 
      end
    end
end