require 'features/features_spec_helper'
 
feature "Order" do
  before do
    @user = create(:user)
    login_as(@user, scope: :user)
    @book = create(:book)
    @delivery = create(:delivery)
    @coupon = create(:coupon)
    @order1 = create(:order, progress: 'in_queue', user_id: @user.id, delivery_id: @delivery.id)
    @order2 = create(:order, progress: 'in_delivery', user_id: @user.id, delivery_id: @delivery.id)
    @order3 = create(:order, progress: 'delivered', user_id: @user.id, delivery_id: @delivery.id)
    @country = create(:country)
    @user.payment.update(number: 1234567891234567, card_code: 123, expiration_date: "2015-02-01")
    @shipping_address = @user.shipping_address.update(first_name: "1", last_name: '1', street_address: '1', city: '1', zip: '1', phone: '1', country_id: @country.id)
    @billing_address = @user.billing_address.update(first_name: "1", last_name: '1', street_address: '1', city: '1', zip: '1', phone: '1', country_id: @country.id)
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

  # scenario "User can change count of chosen books" do
  #   visit root_path
  #   @cart = Order.find_by user_id: nil
  #   @line_item = create(:line_item, book_id: @book.id, order_id: @cart.id)
  #   visit cart_orders_path
  #   fill_in 'quantity'
  #   visit cart_orders_path
  #   expect(page).to have_content 
  # end

  scenario "User can move to edit shipping address" do
    visit categories_path
    @order = Order.find_by user_id: nil
    @order.update(delivery_id: @delivery.id)
    visit confirm_orders_path
    first('.edit_shipping').click_link I18n.t("confirm.edit") 
    expect(page).to have_content I18n.t("addresses.shipping_address")
    expect(page).not_to have_content I18n.t("confirm.shipments")
  end

  scenario "User can move to edit billing address" do
    visit categories_path
    @order = Order.find_by user_id: nil
    @order.update(delivery_id: @delivery.id)
    visit confirm_orders_path
    first('.edit_billing').click_link I18n.t("confirm.edit") 
    expect(page).to have_content I18n.t("addresses.billing_address")
    expect(page).not_to have_content I18n.t("confirm.shipments")
  end

  scenario "User can move to edit delyvery type" do
    visit categories_path
    @order = Order.find_by user_id: nil
    @order.update(delivery_id: @delivery.id)
    visit confirm_orders_path
    first('.edit_delivery').click_link I18n.t("confirm.edit") 
    expect(page).to have_content 'UPS Two Day'
    expect(page).not_to have_content I18n.t("confirm.shipments")
  end

  scenario "User can move to edit payment data" do
    visit categories_path
    @order = Order.find_by user_id: nil
    @order.update(delivery_id: @delivery.id)
    visit confirm_orders_path
    first('.edit_payment').click_link I18n.t("confirm.edit") 
    expect(page).to have_content I18n.t("payment.credit_card")
    expect(page).not_to have_content I18n.t("confirm.shipments")
  end

  # scenario "User can change count of chosen books in confirm_path" do
  #   visit root_path
  #   @cart = Order.find_by user_id: nil
  #   @line_item = create(:line_item, book_id: @book.id, order_id: @cart.id)
  #   visit cart_orders_path
  #   fill_in 'quantity'
  #   visit cart_orders_path
  #   expect(page).to have_content 
  # end

  scenario "User can confirm order" do
    visit categories_path
    @order = Order.find_by user_id: nil
    @order.update(delivery_id: @delivery.id)
    visit confirm_orders_path
    click_link I18n.t("confirm.submit") 
    expect(page).to have_content "R000"
    expect(page).not_to have_content I18n.t("addresses.checkout")
  end

  scenario "User can move back to shop after confirm order" do
    visit categories_path
    @order = Order.find_by user_id: nil
    @order.update(delivery_id: @delivery.id)
    visit complete_orders_path
    click_link I18n.t("complete.submit") 
    expect(page).to have_content I18n.t("categories.shop")
    expect(page).not_to have_content "R000"
  end

  scenario "User can move to cart from orders list" do
    visit orders_path
    click_link I18n.t("orders.submit") 
    expect(page).to have_css('#search')
  end

  scenario "User can view order in queue" do
    visit orders_path
    first('.in_queue').click_link I18n.t("orders.view")
    expect(page).to have_content I18n.t("order.back")
    expect(page).not_to have_content I18n.t("orders.submit")
  end

  scenario "User can view order in delivery" do
    visit orders_path
    first('.in_delivery').click_link I18n.t("orders.view")
    expect(page).to have_content I18n.t("order.back")
    expect(page).not_to have_content I18n.t("orders.submit")
  end

  scenario "User can view delivered order" do
    visit orders_path
    first('.delivered').click_link I18n.t("orders.view")
    expect(page).to have_content I18n.t("order.back")
    expect(page).not_to have_content I18n.t("orders.submit")
  end

  scenario "User can move back to orders list from order details" do
    visit order_path(@order1)
    click_link I18n.t("order.back")
    expect(page).to have_content I18n.t("orders.submit")
    expect(page).not_to have_content I18n.t("order.back")
  end

  scenario "Pressing the link 'Shopping Cart' in the nav bar" do
    visit root_path
    click_link I18n.t('layout.cart')
    expect(page).to have_button I18n.t("cart.empty")
    expect(page).not_to have_css(".welcome")
  end

  scenario "Pressing the link 'Orders' in the nav bar" do
    visit root_path
    click_link I18n.t('layout.orders')
    expect(page).to have_content I18n.t("orders.title")
    expect(page).not_to have_content I18n.t('categories.shop_by_categories')
  end
end