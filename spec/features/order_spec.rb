require 'features/features_spec_helper'
 
feature "Order" do
  let(:user) { create(:user) }
  
  before do
    login_as(user, scope: :user)
    @book = create(:book)
    @delivery = create(:delivery)
    @order = create(:order, user_id: user.id, delivery_id: @delivery.id)
    @order1 = create(:order, user_id: user.id)
    @country = create(:country)
    user.shipping_address.update(country_id: @country.id)
    user.billing_address.update(country_id: @country.id)
    @coupon = create(:coupon)
  end

  scenario "User can view his shopping cart" do
    visit categories_path
    click_link I18n.t('layout.cart')
    expect(page).to have_content I18n.t("cart.quantity")
    expect(page).not_to have_content I18n.t('categories.shop_by_categories')
  end

  scenario "User can empty cart" do
    visit root_path
    @cart = Order.find_by user_id: nil
    @line_item = create(:line_item, book_id: @book.id, order_id: @cart.id)
    visit cart_orders_path
    click_button I18n.t("cart.empty")
    expect(page).to have_content I18n.t('categories.shop_by_categories')
    expect(page).not_to have_content I18n.t("cart.del")
  end

  scenario "User can continue shopping" do
    visit root_path
    @cart = Order.find_by user_id: nil
    @line_item = create(:line_item, book_id: @book.id, order_id: @cart.id)
    visit cart_orders_path
    click_button I18n.t("cart.continue")
    expect(page).to have_content I18n.t('categories.shop_by_categories')
    expect(page).not_to have_content I18n.t("cart.del")
  end

  scenario "User can use coupon" do
    visit cart_orders_path
    fill_in 'search', with: '12345'
    click_button I18n.t("cart.update")
    expect(page).to have_content 'You coupon has successfully'
  end

  scenario "User can place an order" do
    visit root_path
    @cart = Order.find_by user_id: nil
    @line_item = create(:line_item, book_id: @book.id, order_id: @cart.id)
    visit cart_orders_path
    click_button I18n.t("cart.checkout")
    expect(page).to have_content I18n.t("addresses.billing_address")
    expect(page).not_to have_content I18n.t("cart.del")
  end
  
  scenario "User can remove book from cart" do
    visit root_path
    @cart = Order.find_by user_id: nil
    @line_item = create(:line_item, book_id: @book.id, order_id: @cart.id)
    visit cart_orders_path
    click_button I18n.t("cart.del")
    expect(page).to have_content I18n.t("cart.subtotal")
    expect(page).not_to have_content I18n.t("cart.del")
  end

  # scenario "User can move to edit shipping address" do
  #   visit cart_orders_path
  #   @cart = Order.find_by user_id: nil
  #   visit confirm_orders_path
  #   click_link edit_shipping_address_path(current_user.shipping_address)
  #   # expect(page).to have_content I18n.t("cart.subtotal")
  #   # expect(page).not_to have_content I18n.t("cart.del")
  # end

  # scenario "User can move to edit billing address" do

  # end

  # scenario "User can move to edit delyvery type" do

  # end

  # scenario "User can move to edit payment data" do

  # end

  # scenario "User can confirm order" do

  # end

  # scenario "User can move back to shop after confirm order" do

  # end

  scenario "User can move to cart from orders list" do
    visit orders_path
    click_link I18n.t("orders.view")
    expect(page).to have_content I18n.t("order.back")
    expect(page).not_to have_content I18n.t("orders.title")
  end

  scenario "User can view order" do

  end
end