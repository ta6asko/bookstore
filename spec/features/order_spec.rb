require 'features/features_spec_helper'
 
feature "Order" do
  let(:user) { create(:user) }
  
  before do
    login_as(user, scope: :user)
    @book = create(:book)
    @order1 = create(:order, user_id: user.id)
    @order2 = create(:order, progress: 'in_queue', user_id: user.id)
    @order3 = create(:order, progress: 'in_delivery', user_id: user.id)
    @order4 = create(:order, progress: 'delivered', user_id: user.id)
  end

  scenario "User can view his shopping cart" do
    visit categories_path
    click_link I18n.t('layout.cart')
    expect(page).to have_content I18n.t("cart.quantity")
    expect(page).not_to have_content I18n.t('categories.shop_by_categories')
  end

  scenario "User can add books to cart" do
    visit book_path(@book)
    click_button I18n.t('books.submit')
    expect(page).to have_content I18n.t("cart.quantity")
    expect(page).not_to have_content I18n.t('X')
  end

  scenario "User can empty cart" do
    visit cart_orders_path
    click_link I18n.t("cart.empty")
    expect(page).to have_content I18n.t('categories.shop_by_categories')
    expect(page).not_to have_content I18n.t('X')
  end

  scenario "User can continue shopping" do

  end

  scenario "User can use coupon" do

  end

  scenario "User can place an order" do

  end

  scenario "User can remove book from cart" do

  end

  scenario "User can move to edit billing address" do

  end

  scenario "User can move to edit shipping address" do

  end

  scenario "User can move to edit delyvery type" do

  end

  scenario "User can move to edit payment data" do

  end

  scenario "User can confirm order" do

  end

  scenario "User can move back to shop after confirm order" do

  end

  scenario "User can move to cart from orders list" do

  end

  scenario "User can view order" do

  end
end