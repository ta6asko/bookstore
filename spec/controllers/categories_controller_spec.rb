require 'controllers/controllers_spec_helper'

describe CategoriesController do
  before do
    @category = create(:category)
    redefine_cancan_abilities
  end

  context "GET #index" do
    before do
      get :index, id: @category.id 
    end

    it "responds successfully with an HTTP 200 status code" do
      expect(response.status).to eq(200)
    end

    it "renders the #index view" do 
      response.should render_template :index 
    end
  end

  context "GET #show" do
    before do
      get :show, id: @category.id 
    end

    it "responds successfully with an HTTP 200 status code" do
      expect(response.status).to eq(200)
    end

    it "renders the #show view" do 
      response.should render_template :show 
    end
  end
end