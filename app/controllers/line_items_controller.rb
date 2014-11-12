class LineItemsController < ApplicationController
  include CurrentCart

  before_action :set_cart, only: [:create]

  def create
    book = Book.find(params[:book_id]) 
    @line_item = @cart.add_book(book.id, params[:line_item][:quantity])
    if @line_item.save
      redirect_to @line_item.cart 
    else
      render action: 'new'
    end
  end

  def destroy
    current_item = LineItem.find(params[:id])
    current_item.destroy
    redirect_to cart_path
  end

  private

    def line_item_params
      params.require(:line_item).permit(:book_id)
    end
end
