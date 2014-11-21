class RatingController < ApplicationController
  load_and_authorize_resource
  def new
    @book = Book.find(params[:id])
  end
end
