class LineItemsController < ApplicationController
  include CurrentCart

  before_action :set_cart, only: [:create]
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]

  def index
    @line_items = LineItem.all
  end

  def new
    @line_item = LineItem.new
  end

  def create
    book = Book.find(params[:book_id])
    @line_item = @cart.add_book(book.id)
    if @line_item.save
      redirect_to @line_item.cart 
    else
      render action: 'new'
    end
  end

  def destroy
    @line_item.destroy
  end

  private
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    def line_item_params
      params.require(:line_item).permit(:book_id)
    end
end