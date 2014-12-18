require 'features/features_spec_helper'
 
feature "Book" do
  before do
    @order = create(:order)
    @book = create(:book)
  end
  
  scenario "User can view detailed information on a book" do
    visit categories_path
    click_link(@book.title)
    expect(page).to have_content @book.full_description.first(500)
    expect(page).not_to have_content I18n.t('categories.shop_by_categories')
  end
end