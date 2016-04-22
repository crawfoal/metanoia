module AuthorizationHelper
  def expect_standard_not_authorized_response
    expect(flash[:alert]).to eq 'You are not authorized to perform this action.'
    expect(response).to redirect_to root_path
  end

  def pretend_not_authorized(authorization_method_name)
    policy = double(authorization_method_name => false)
    allow(GymPolicy).to receive(:new).and_return(policy)
  end
end

RSpec.configure do |config|
  config.include AuthorizationHelper, type: :controller
end
