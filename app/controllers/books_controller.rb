class BooksController < ApplicationController
  include BooksHelper
  include CurrentCart
  
  before_action :set_cart, only: [:index]
  def index
  	@books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    @comment = @book.comments
  end

  def new
    @book = Book.new
  end

  def create
  	@book = Book.new(book_params)
    if @book.save   
      redirect_to @book
    else
      render "new"
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
   
    if @book.update(book_params) 
      redirect_to @book
    else
      render "edit"
    end
  end

  def destroy

  end

  private

  def book_params
    params.require(:book).permit(:title, :short_description, :full_description, :price)
  end

end
