class RatingController < ApplicationController
  def new
    @book = Book.find(params[:id])
  end
end
