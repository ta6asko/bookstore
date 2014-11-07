class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    @books = Book.page(params[:page]).per(9)
  end

  def show
    @categories = Category.all
    @category = Category.find(params[:id])
    @books = @category.books.page(params[:page]).per(9)
  end
end
