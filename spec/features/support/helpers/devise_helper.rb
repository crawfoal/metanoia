module DeviseFeatureHelper
  # Use the stubbed out methods unless you're testing something related to
  # sessions and registration. It saves about half a second per feature spec.
  # The `login_as` and `logout` methods are from Warden::Test::Helpers.
  def stubbed_sign_in(user)
    login_as(user, scope: :user)
  end

  def stubbed_sign_out
    logout(:user)
  end

  def sign_up
    attributes = FactoryGirl.attributes_for :user
    visit root_path
    click_on 'Sign Up'
    within '.sign-up' do
      fill_in 'Email', with: attributes[:email]
      fill_in 'Password', with: attributes[:password]
      fill_in 'Password confirmation', with: attributes[:password]
      find('input[type="submit"]').click
    end
    User.find_by_email attributes[:email]
  end

  def sign_in(user, options = {})
    visit root_path
    click_on 'Sign In'
    within '.sign-in' do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: (options[:password] || user.password)
      find('input[type="submit"]').click
    end
  end

  def sign_out
    click_on 'Sign Out'
  end
end

RSpec.configure do |config|
  config.include Warden::Test::Helpers, type: :feature
  Warden.test_mode!
  config.after(:each, type: :feature) { Warden.test_reset! }

  config.include DeviseFeatureHelper, type: :feature
end
