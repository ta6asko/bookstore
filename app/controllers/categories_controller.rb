class CategoriesController < ApplicationController
  # load_and_authorize_resource
  include CurrentOrder
  before_action :set_order

  def index
    @books = Book.page(params[:page]).per(9)
  end

  def show
    @category = Category.find(params[:id])
    @books = @category.books.page(params[:page]).per(9)
  end
end
