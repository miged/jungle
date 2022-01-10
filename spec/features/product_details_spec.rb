require 'rails_helper'
require 'support/image'

RSpec.feature "ProductDetails", type: :feature, js: true do
  # SETUP
  before :each do
    Product.destroy_all
    Category.destroy_all
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see product page" do
    visit root_path
    page.first('.product').click_link('Details')
    expect(page).to have_css 'article.product-detail'
  end
end
