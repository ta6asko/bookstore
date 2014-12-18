require 'features/features_spec_helper'
 
feature "Delivery" do
  let(:user) { create(:user) }
  
  before do
    login_as(user, scope: :user)
    @book = create(:book)
    @order = create(:order, user_id: user.id)
  end

  scenario "User can change delivery type" do

  end
end