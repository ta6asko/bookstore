class LineItemsController < ApplicationController
  include CurrentCart

  before_action :set_cart, only: [:create]
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]

  def index
    @line_items = LineItem.all
    respond_with(@line_items)
  end

  def show
    respond_with(@line_item)
  end

  def new
    @line_item = LineItem.new
    respond_with(@line_item)
  end

  def edit
  end

  def create
    book = Book.find(params[:book_id])
    @line_item = @cart.line_items.build(book: book)
    respond_to do |format|

      if @line_item.save
        format.html { redirect_to carts_path, notice: 'Line item was successfully created.' }
        format.json { render action: 'index', status: :created, location: @line_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @line_item.update(line_item_params)
    respond_with(@line_item)
  end

  def destroy
    @line_item.destroy
    respond_with(@line_item)
  end

  private
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    def line_item_params
      params.require(:line_item).permit(:book_id, :cart_id)
    end
end
