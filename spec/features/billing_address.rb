require 'features/features_spec_helper'
 
feature "BillingAddress" do
  let(:user) { create(:user) }
  
  before do
    login_as(user, scope: :user)
    @book = create(:book)
    @order = create(:order, user_id: user.id)
  end

  scenario "User can edit billing address" do

  end

  scenario "User can 'Use Billing Address' checkbox" do

  end

end