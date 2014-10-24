class CartController < ApplicationController
  def index
    @books = Book.all
  end
end
