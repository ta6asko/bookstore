require 'features/features_spec_helper'
 
feature "BillingAddress" do
  let(:user) { create(:user) }
  
  before do
    login_as(user, scope: :user)
    @book = create(:book)
    @order = create(:order, user_id: user.id)
    @country = create(:country)
    @delivery = create(:delivery)
  end

  scenario "User can edit billing address" do
    visit edit_billing_address_path(user)
    within ".edit_billing_address" do
      fill_in 'billing_address_first_name', with: Faker::Name.first_name
      fill_in 'billing_address_last_name', with: Faker::Name.last_name
      fill_in 'billing_address_street_address', with: Faker::Address.street_name
      fill_in 'billing_address_city', with: Faker::Address.city
      select "Ukraine", :from => 'billing_address_country_id'
      fill_in 'billing_address_zip', with: Faker::Address.zip_code
      fill_in 'billing_address_phone', with: Faker::PhoneNumber.phone_number
      click_button I18n.t("addresses.submit")
    end
    expect(page).to have_content I18n.t("addresses.shipping_address")
  end

  scenario "User can 'Use Billing Address' checkbox" do
    visit edit_billing_address_path(user)
    within ".edit_billing_address" do
      fill_in 'billing_address_first_name', with: Faker::Name.first_name
      fill_in 'billing_address_last_name', with: Faker::Name.last_name
      fill_in 'billing_address_street_address', with: Faker::Address.street_name
      fill_in 'billing_address_city', with: Faker::Address.city
      select "Ukraine", :from => 'billing_address_country_id'
      fill_in 'billing_address_zip', with: Faker::Address.zip_code
      fill_in 'billing_address_phone', with: Faker::PhoneNumber.phone_number
      check "billing_address_shipping"
      click_button I18n.t("addresses.submit")
    end
    expect(page).to have_content 'UPS Two Day'
  end

end