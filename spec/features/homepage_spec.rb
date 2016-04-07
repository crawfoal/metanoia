require 'feature_helper'

RSpec.feature "Homepage", type: :feature do
  scenario "guest visits homepage" do
    visit root_path

    expect(page).to have_content "Welcome to Climbalytics!"
  end
end
