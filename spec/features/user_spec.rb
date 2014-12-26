require 'features/features_spec_helper'
 
feature "User" do
  before do
    @user = create(:user)
    login_as(@user, scope: :user)
    @country = create(:country)
    @book = create(:book)
  end

  scenario "User can edit billing address in settings" do
    visit edit_user_path(@user)
    within ".edit_billing_address" do
      fill_in 'billing_address_first_name', with: Faker::Name.first_name
      fill_in 'billing_address_last_name', with: Faker::Name.last_name
      fill_in 'billing_address_street_address', with: Faker::Address.street_name
      fill_in 'billing_address_city', with: Faker::Address.city
      select "Ukraine", :from => 'billing_address_country_id'
      fill_in 'billing_address_zip', with: Faker::Address.zip_code
      fill_in 'billing_address_phone', with: Faker::PhoneNumber.phone_number
      click_button I18n.t("settings.save")
    end
    expect(page).to have_content "Billing address has successfully changed"
  end

  scenario "User can edit shipping address in settings" do
    visit edit_user_path(@user)
    within ".edit_shipping_address" do
      fill_in 'shipping_address_first_name', with: Faker::Name.first_name
      fill_in 'shipping_address_last_name', with: Faker::Name.last_name
      fill_in 'shipping_address_street_address', with: Faker::Address.street_name
      fill_in 'shipping_address_city', with: Faker::Address.city
      select "Ukraine", :from => 'shipping_address_country_id'
      fill_in 'shipping_address_zip', with: Faker::Address.zip_code
      fill_in 'shipping_address_phone', with: Faker::PhoneNumber.phone_number
      click_button I18n.t("settings.save")
    end
    expect(page).to have_content "Shipping address has successfully changed"
  end

  scenario "User can edit email in settings" do
    visit edit_user_path(@user)
    within ".edit_email" do
      fill_in 'user_email', with: Faker::Internet.email
      click_button I18n.t("settings.save")
    end
    expect(page).to have_content "Email has successfully changed"
  end

  scenario "User can edit password in settings" do
    visit edit_user_path(@user)
    within ".edit_pass" do
      fill_in 'user_current_password', with: '12345678'
      fill_in 'user_password', with: Faker::Internet.password(8)
      click_button I18n.t("settings.save")
    end
    expect(page).to have_content "Password has successfully changed"
  end

  scenario "User can edit remove account in settings" do
    visit edit_user_path(@user)
    within ".destroy" do
      check "user_check_del"
      click_button I18n.t("settings.destroy_submit")
    end
    expect(page).to have_content "Account has removed"
  end

  scenario "Pressing the link 'Settings' in the nav bar" do
    visit root_path
    click_link I18n.t('layout.settings')
    expect(page).not_to have_css ('.welcome')
    expect(page).to have_css('.edit_billing_address')
  end

  scenario "Pressing the link 'Sign out' in the nav bar" do
    visit root_path
    click_link I18n.t('layout.sign_out')
    expect(page).not_to have_content I18n.t('layout.sign_out')
    expect(page).to have_content 'Signed out successfully.'
  end

  scenario "Pressing the link 'Sign in' in the nav bar" do
    logout(:user)
    visit root_path
    click_link I18n.t('layout.sign_in')
    expect(page).not_to have_css(".welcome") 
    expect(page).to have_content "Don't have an account?"
  end

  scenario "Pressing the link 'Sign up' in the nav bar" do
    logout(:user)
    visit root_path
    click_link I18n.t('layout.sign_up')
    expect(page).not_to have_css(".welcome") 
    expect(page).to have_content "Have an account?"
  end

  scenario "Pressing the link 'Sign up' in 'Sign in' page" do
    logout(:user)
    visit new_user_session_path
    first('.sign_up').click_link I18n.t('layout.sign_up')
    expect(page).not_to have_content "Don't have an account?"
    expect(page).to have_content "Have an account?" 
  end

  scenario "Pressing the link 'Sign in' in 'Sign up' page" do
    logout(:user)
    visit new_user_registration_path
    first('.sign_in').click_link I18n.t('layout.sign_in') 
    expect(page).not_to have_content "Have an account?"
    expect(page).to have_content "Don't have an account?"
  end

  scenario "Pressing the button 'Sign in'" do
    logout(:user)
    @user = create(:user, email: "test@gmail.com", password: '12345678')
    visit new_user_session_path
    within ".new_user" do
      fill_in 'user_email', with: "test@gmail.com"
      fill_in 'user_password', with: '12345678'
      click_button 'Log in'
    end
    expect(page).not_to have_content "Don't have an account?"
    expect(page).to have_content "Signed in successfully."
  end

  scenario "Pressing the button 'Sign up'" do
    logout(:user)
    visit new_user_registration_path
    within ".new_user" do
      fill_in 'user_email', with: Faker::Internet.email
      fill_in 'user_password', with: '12345678'
      fill_in 'user_password_confirmation', with: '12345678'
      click_button 'Sign up'
    end
    expect(page).not_to have_content "Have an account?"
    expect(page).to have_content "Welcome! You have signed up successfully."
  end

  scenario "omniauth-facebook" do
    logout(:user)
    visit new_user_session_path
    find("img[@alt='Facebook']").click
    expect(page).to have_content "Successfully authenticated from Facebook account."
  end
end