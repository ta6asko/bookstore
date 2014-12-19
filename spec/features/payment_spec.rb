require 'features/features_spec_helper'
 
feature "Payment" do
  let(:user) { create(:user) }
  
  before do
    login_as(user, scope: :user)
    @book = create(:book)
    @delivery = create(:delivery)
    @payment = create(:payment, user_id: user.id)
    @order = create(:order, user_id: user.id, delivery_id: @delivery.id)
    
  end

  scenario "User can edit payment data" do
    visit edit_payment_path(user)
    click_button I18n.t("addresses.submit")
    expect(page).to have_content I18n.t("confirm.confirm")
  end
end