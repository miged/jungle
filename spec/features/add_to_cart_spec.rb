require 'rails_helper'
require 'support/image'

RSpec.feature "AddToCart", type: :feature, js: true do
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

  scenario "They add to cart" do
    visit root_path
    navbar = page.find 'nav.navbar'
    expect(navbar).to have_text 'My Cart (0)'
    page.first('.product').click_button('Add')
    expect(navbar).to have_text 'My Cart (1)'
  end
end
