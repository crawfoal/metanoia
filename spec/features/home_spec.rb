require 'feature_helper'

RSpec.feature 'Homepage', type: :feature do
  scenario 'guest visits homepage and creates an account' do
    visit root_path

    user = sign_up_user
    expect(page).to be_user_default_page
    expect(user.current_role).to eq 'athlete'
  end

  scenario 'user signs in and out' do
    visit root_path
    expect(page).to_not have_selector '#sign_out'

    create_and_login_user
    expect(page).to be_user_default_page
    expect(page).to have_selector '#sign_out'

    visit root_path
    expect(page).to_not have_selector '.sign-up'
    expect(page).to_not have_selector '.sign-in'

    sign_out
    expect(page).to be_homepage
  end
end
