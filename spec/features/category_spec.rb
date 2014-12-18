require 'features/features_spec_helper'

feature "Book" do
  before do
    @order = create(:order)
    @book = create(:book)
    @category = create(:category)
  end

  scenario "User can view list of all books" do
    visit books_path
    click_link I18n.t('layout.shop')
    expect(page).to have_content I18n.t('categories.shop_by_categories')
    expect(page).not_to have_content I18n.t('books.submit')
  end

  scenario "User can view list of books by category" do
    visit categories_path
    click_link(@category.name)
    expect(page).to have_content I18n.t("categories.categories")
  end
end