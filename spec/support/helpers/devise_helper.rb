module DeviseHelper
  def set_devise_mapping
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  def create_and_login_user(factory_name = :user)
    user = create(factory_name)
    login user
  end

  def login(user)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in user
  end
end

RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
  config.include DeviseHelper, type: :controller
end
