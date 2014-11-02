class RatingsController < ApplicationController
  
  def index
    
  end

  def new
    @book = Book.find(params[:book_id])
  end
  def create
    @book = Book.find(params[:book_id])
    @books = Book.all
    @rating = Rating.new
    if @rating.save
      redirect_to book_path(@book)
    else
      render 'new'
    end
  end
end
