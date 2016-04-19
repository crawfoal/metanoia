require 'feature_helper'

RSpec.feature "Homepage", type: :feature do
  scenario "guest visits homepage and creates an account" do
    visit root_path

    sign_up_user
    expect(page).to have_selector '.gyms.index'
  end
end
