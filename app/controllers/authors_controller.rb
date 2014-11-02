class AuthorsController < ApplicationController
  def index
    @authors = Author.all
  end

  def show
    @authors = Author.all
  end
end
