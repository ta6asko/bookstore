class CommentsController < ApplicationController
  
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_book
  
  def index
    @comment = @book.comments.last
  end
  
  def new
    @comment = Comment.new
  end

  def create
    @comment = @book.comments.create(comment_params)
    if @comment.save
      redirect_to book_comments_path
    else
      render "new"
    end
  end

  private

    def set_book
      @book = Book.find(params[:book_id])
    end  

    def comment_params
      params[:comment].permit(:user_name, :title, :comment)
    end
end
