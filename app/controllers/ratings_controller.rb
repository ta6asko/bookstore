class RatingsController < ApplicationController
  before_filter :authenticate_user!

    def create
      @book = Book.find_by_id(params[:book_id])
      if current_user.ratings.any?
        @rating = current_user.ratings.find_by_book_id(@book.id)
      else
        @rating = Rating.new(params[:value])
        @rating.book_id = @book.id
        @rating.user_id = current_user.id
        if @rating.save
          respond_to do |format|
            format.js
          end
        end
      end
    end

    def update
      @book = Book.find_by_id(params[:book_id])
      @rating = current_user.ratings.find_by_book_id(@book.id)
      if @rating.update_attributes(value: params[:rating][:value])
        render json: @rating
      end
    end

    def create_comment

    end

end
