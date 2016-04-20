module DeviseFeatureHelper
  def sign_up_user
    new_user = FactoryGirl.build :user
    fill_in 'Email', with: new_user.email
    fill_in 'Password', with: new_user.password
    fill_in 'Password confirmation', with: new_user.password
    find('input[type="submit"]').click
  end

  def login_user
    user = FactoryGirl.create :user
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    find('input[type="submit"]').click
  end

  def sign_out
    click_on 'Sign Out'
  end
end

RSpec.configure do |config|
  config.include DeviseFeatureHelper, type: :feature
end
