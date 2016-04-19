module DeviseFeatureHelper
  def sign_up_user
    new_user = FactoryGirl.build :user
    fill_in 'Email', with: new_user.email
    fill_in 'Password', with: new_user.password
    fill_in 'Password confirmation', with: new_user.password
    click_on 'Sign up'
  end
end

RSpec.configure do |config|
  config.include DeviseFeatureHelper, type: :feature
end
