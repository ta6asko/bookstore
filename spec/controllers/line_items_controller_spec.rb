require 'controllers/controllers_spec_helper'

describe LineItemsController do
  before do
    # binding.pry

    @order = create(:order)
    @book = create(:book)
    # @line_item = create(:line_item)
    redefine_cancan_abilities
  end

  context "POST #create" do
    before do
      post :create, line_item: Factory.attributes_for(book_id: @book.id, order_id: @order.id)
    end
      
    it "redirects to the cart_orders_path if line_item is valid" do
      response.should redirect_to cart_orders_path
    end
  end

  context "PATCH #update" do 
    before do
      patch :update, id: @line_item.id, line_item: attributes_for(:line_item, quantity: 6)
    end

    it "redirects to the cart_orders_path if line_item updated" do
      response.should redirect_to cart_orders_path
    end

  end

  context 'DELETE #destroy' do
    before do
      delete :destroy, { order_id: @order.id, id: @line_item.id }
    end

    it "redirects to cart_orders_path" do 
      expect(response).to redirect_to cart_orders_path 
    end
  end
end