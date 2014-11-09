class CommentsController < ApplicationController
  def index
    @book = Book.find(params[:book_id])
    @comment = @book.comments.last
  end

  def new
    @comment = Comment.new
    @book = Book.find(params[:book_id])
  end

  def create
    @book = Book.find(params[:book_id])
    @comment = @book.comments.create(comment_params)
    if @comment.save
      redirect_to book_comments_path
    else
      render "new"
    end
  end

  private

    def comment_params
      params[:comment].permit(:user_name, :title, :comment)
    end
end
