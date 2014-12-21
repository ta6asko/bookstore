require 'features/features_spec_helper'
 
feature "Book" do
  before do
    @order = create(:order)
    @book = create(:book)
  end
  
  scenario "Pressing the link in the book title" do
    visit categories_path
    click_link(@book.title)
    expect(page).to have_content @book.full_description.first(500)
    expect(page).not_to have_content I18n.t('categories.shop_by_categories')
  end

  scenario "Pressing the link 'The Bookstore' in the nav bar" do
    visit categories_path
    click_link I18n.t('layout.app_title')
    expect(page).not_to have_content I18n.t('categories.shop_by_categories')
    expect(page).to have_css('.welcome')
  end

  scenario "Pressing the link 'HOME' in the nav bar" do
    visit categories_path
    click_link I18n.t('layout.home')
    expect(page).not_to have_content I18n.t('categories.shop_by_categories')
    expect(page).to have_css('.welcome')
  end
end