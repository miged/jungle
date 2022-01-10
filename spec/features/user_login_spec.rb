require 'rails_helper'

RSpec.feature "UserLogin", type: :feature do
  # SETUP
  before :each do
    User.destroy_all
    User.create!({
      first_name: 'John',
      last_name: 'Doe',
      email: 'jd@email.com',
      password: 'P@ssw0rd123',
      password_confirmation: 'P@ssw0rd123'
      })
  end

  scenario "The user logs in" do
    visit '/login'
    fill_in 'email', with: 'jd@email.com'
    fill_in 'password', with: 'P@ssw0rd123'
    page.click_button('Log in')

    expect(page).to have_text('Signed in as John')
  end
end
