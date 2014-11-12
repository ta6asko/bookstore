class CategoriesController < ApplicationController
   
  include CurrentCart
  before_action :set_cart, only: [:index, :show]

  def index
    @books = Book.page(params[:page]).per(9)
  end

  def show
    @category = Category.find(params[:id])
    @books = @category.books.page(params[:page]).per(9)
  end
end
