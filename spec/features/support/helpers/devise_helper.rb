module DeviseFeatureHelper
  def sign_up_user
    new_user = FactoryGirl.build :user
    visit root_path
    click_on 'Sign Up'
    within '.sign-up' do
      fill_in 'Email', with: new_user.email
      fill_in 'Password', with: new_user.password
      fill_in 'Password confirmation', with: new_user.password
      find('input[type="submit"]').click
    end
    User.find_by_email new_user.email
  end

  def create_and_login_user(factory_name = :user)
    user = FactoryGirl.create factory_name
    login(user.email, user.password)
    user
  end

  def login(email, password)
    visit root_path
    click_on 'Sign In'
    within '.sign-in' do
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      find('input[type="submit"]').click
    end
  end

  def sign_out
    click_on 'Sign Out'
  end
end

RSpec.configure do |config|
  config.include DeviseFeatureHelper, type: :feature
end
