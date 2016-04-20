module DeviseHelper
  def set_devise_mapping
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end
end

RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
  config.include DeviseHelper, type: :controller
end
