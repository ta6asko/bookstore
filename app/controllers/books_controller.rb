class BooksController < ApplicationController
  load_and_authorize_resource
  include CurrentOrder
  before_action :set_order

  def index
  	@books = Book.all
    @line_item = LineItem.new
  end

  def show
    @line_item = LineItem.new
    @book = Book.find(params[:id])
  end

end
