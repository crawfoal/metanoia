require 'feature_helper'

RSpec.feature "Homepage", type: :feature, js: true do
  scenario "guest visits homepage and creates an account" do
    visit root_path

    sign_up_user
    expect(page).to be_user_default_page
  end

  scenario "user signs in and out" do
    visit root_path

    click_on 'Sign In'
    expect(page).to have_selector 'form[action="/sign_in"]'
    login_user
    expect(page).to be_user_default_page

    # click_on 'Sign Out'
    # expect(page).to be_user_default_page
  end

  scenario "signed-in user clicks on logo" do
    skip

    visit root_path
    click_on 'Sign In'
    login_user

    find('.logo').click
    expect(page).to be_user_default_page
  end
end
