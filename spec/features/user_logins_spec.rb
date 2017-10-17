require 'rails_helper'

RSpec.feature "User logs in", type: :feature, js: true do
  
  before :each do
    @max = User.create!(
      first_name: 'Max',
      last_name: 'Jones',
      email: 'max@jones.com',
      password: 'password',
      password_confirmation: 'password'
    )
  end

  scenario "User is redirected to home page" do
    visit root_path
    click_link 'Login'
    fill_in 'Email', with: 'max@jones.com'
    fill_in 'Password', with: 'password'
    click_button 'Login'

    expect(page).to have_content 'Hello, Max!'
    save_screenshot
  end
end
