class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    @books = Book.all
  end

  def show
    @categories = Category.all
    @category = Category.find(params[:id])
    @books = @category.books(params[:id])
  end
end
