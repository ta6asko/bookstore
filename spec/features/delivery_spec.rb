require 'features/features_spec_helper'
 
feature "Delivery" do
  let(:user) { create(:user) }
  
  before do
    login_as(user, scope: :user)
    @book = create(:book)
    @order = create(:order, user_id: user.id)
    @delivery = create(:delivery)
  end

  scenario "User can change delivery type" do
    visit edit_delivery_path(user)
    click_button I18n.t("addresses.submit")
    expect(page).to have_content I18n.t("payment.credit_card")
    expect(page).not_to have_content 'UPS Two Day'
  end
end