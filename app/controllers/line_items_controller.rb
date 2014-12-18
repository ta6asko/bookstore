class LineItemsController < ApplicationController
  
  load_and_authorize_resource
  
  def create
    book = Book.find(params[:book_id]) 
    @line_item = @order.add_book(book.id, params[:line_item][:quantity])
    redirect_to cart_orders_path if @line_item.save
  end

  def destroy
    current_item = LineItem.find(params[:id])
    current_item.destroy
    redirect_to cart_orders_path
  end

  private

    def line_item_params
      params.require(:line_item).permit(:book_id)
    end
end
