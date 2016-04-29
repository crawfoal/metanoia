require 'feature_helper'

RSpec.feature 'Profile', type: :feature, js: true do
  scenario 'user edits profile' do
    user = create :user
    sign_in user

    click_on 'Profile'
    within '#account_settings' do
      find('#edit_account_settings').click
    end

    fill_in 'New password', with: 'new_password'
    fill_in 'Confirm new password', with: 'new_password'
    fill_in 'Current password', with: user.password
    click_on 'Save'
    user.reload

    expect(page).to show_flash_with 'success'

    sign_out
    sign_in(user, password: 'new_password')
    expect(page).to show_flash_with 'Signed in successfully.'
  end
end
