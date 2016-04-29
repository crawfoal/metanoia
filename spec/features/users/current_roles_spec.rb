require 'feature_helper'

RSpec.feature 'User Roles', type: :feature, js: true do
  scenario 'user switches current role' do
    user = create :admin
    user.add_role :athlete
    sign_in user
    find_link('Switch Roles').hover
    expect(page).to have_select('user[current_role]', selected: 'admin')
    select 'athlete'
    user.reload
    expect(user.current_role).to eq 'athlete'
    find_link('Switch Roles').hover
    expect(page).to have_select('user[current_role]', selected: 'athlete')
  end
end
