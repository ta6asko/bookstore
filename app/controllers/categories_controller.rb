class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    @books = Book.all
  end

  def show
    @category = Category.find(params[:id])
  end
end
