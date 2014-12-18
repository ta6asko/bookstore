require 'controllers/controllers_spec_helper'

describe BooksController do
  before do
    @book = create(:book)
    redefine_cancan_abilities
  end

  context "GET #index" do
    before do
      get :index, id: @book.id 
    end

    it "responds successfully with an HTTP 200 status code" do
      expect(response.status).to eq(200)
    end

    it "renders the #index view" do 
      response.should render_template :index 
    end
  end

  context "GET #show" do
    before (:each) do
      get :show, id: @book.id 
    end

    it "responds successfully with an HTTP 200 status code" do
      expect(response.status).to eq(200)
    end

    it "renders the #show view" do 
      response.should render_template :show 
    end
  end
end