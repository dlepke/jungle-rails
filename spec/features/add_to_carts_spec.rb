require 'rails_helper'

RSpec.feature "Visitor adds an item to cart", type: :feature, js: true do

  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "The cart total increments by one" do

    visit root_path
    # add an item to the cart here
    find('.add_item_link', match: :first).click

    # check if cart item count incremented on the page
    expect(page).to have_content 'My Cart (1)'
    save_screenshot
  end
end
