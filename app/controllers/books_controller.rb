class BooksController < ApplicationController

  include CurrentCart
  before_action :set_cart, only: [:index, :show]

  def index
  	@books = Book.all
    @line_item = LineItem.new
  end

  def show
    @line_item = LineItem.new
    @book = Book.find(params[:id])
  end

end
