require 'controllers/controllers_spec_helper'

describe CommentsController do
  before do
    @user = create(:user)
    @book = create(:book)
    allow(controller).to receive(:current_user) { @user }
    redefine_cancan_abilities
  end

  context "GET #index" do
    context 'being signed in' do
      before do
        sign_in @user
        @comment = create(:comment, book_id: @book.id)
        get :index, book_id: @book.id 
      end

      it "responds successfully with an HTTP 200 status code" do
        expect(response.status).to eq(200)
      end

      it "renders the index template" do
        expect(response).to render_template("index")
      end
    end

    context 'being not signed in' do
      before do
        get :index, book_id: @book.id 
      end

      it { should redirect_to new_user_session_path }
    end

    context 'cancan doesnt allow :index' do
      before do
        sign_in @user
        @ability.cannot :index, Comment
        get :index, book_id: @book.id 
      end

      it { should redirect_to root_path }
    end
  end

  context "GET #new" do
    context 'being signed in' do
      before do
        sign_in @user
        get :new, book_id: @book.id 
      end

      it "responds successfully with an HTTP 200 status code" do
        expect(response.status).to eq(200)
      end

      it "renders the #new view" do 
        response.should render_template :new 
      end
    end

    context 'being not signed in' do
      before do
        get :new, book_id: @book.id 
      end

      it { should redirect_to new_user_session_path }
    end

    context 'cancan doesnt allow :new' do
      before do
        sign_in @user
        @ability.cannot :new, Comment
        get :new, book_id: @book.id 
      end

      it { should redirect_to root_path }
    end
  end
  context "POST create" do
    context 'being signed in' do
      before do
        sign_in @user
        post :create, book_id: @book.id, comment: attributes_for(:comment) 
      end 

      it "redirects to the book_comments_path if comment is valid" do
        response.should redirect_to book_comments_path(@book)
      end
    end

    context 'being not signed in' do
      before do
        post :create, book_id: @book.id, comment: attributes_for(:comment) 
      end

      it { should redirect_to new_user_session_path }
    end

    context 'cancan doesnt allow :create' do
      before do
        sign_in @user
        @ability.cannot :create, Comment
        post :create, book_id: @book.id, comment: attributes_for(:comment) 
      end

      it { should redirect_to root_path }
    end
  end
end