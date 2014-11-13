class LineItemsController < ApplicationController
  include CurrentOrder

  before_action :set_order, only: [:create]

  def create
    book = Book.find(params[:book_id]) 
    @line_item = @order.add_book(book.id, params[:line_item][:quantity])
    if @line_item.save
      redirect_to cart_orders_path
    else
      render action: 'new'
    end
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
