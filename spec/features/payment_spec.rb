require 'features/features_spec_helper'
 
feature "Payment" do
  let(:user) { create(:user) }
  
  before do
    login_as(user, scope: :user)
    @book = create(:book)
    @delivery = create(:delivery)
    @payment = create(:payment, user_id: user.id)
    @country = create(:country)
    @shipping_address = user.shipping_address.update(first_name: "1", last_name: '1', street_address: '1', city: '1', zip: '1', phone: '1', country_id: @country.id)
    @billing_address = user.billing_address.update(first_name: "1", last_name: '1', street_address: '1', city: '1', zip: '1', phone: '1', country_id: @country.id)
  end

  scenario "User can edit payment data" do
    visit categories_path
    @order = Order.find_by user_id: nil
    @order.update(delivery_id: @delivery.id)
    visit edit_payment_path(@payment)
    within ".edit_payment" do
      fill_in 'payment_number', with: Faker::Number.number(16)
      select "December", from: 'payment[expiration_date(2i)]'
      select 2012, from: 'payment[expiration_date(1i)]'
      fill_in 'payment_card_code', with: Faker::Number.number(3)
      click_button I18n.t("addresses.submit")
    end
    expect(page).to have_content I18n.t("confirm.shipments")
  end
end