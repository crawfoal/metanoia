module DeviseHelper
  def set_devise_mapping
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  def login_user(factory_name = :user)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    user = create(factory_name)
    sign_in user
  end
end

RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
  config.include DeviseHelper, type: :controller
end
