module AuthorizationHelper
  def expect_standard_not_authorized_response
    expect(flash[:alert]).to eq 'You are not authorized to perform this action.'
    expect(response).to redirect_to root_path
  end

  def pretend_not_authorized(authorization_method_name, policy_class_name = nil)
    policy = double(authorization_method_name => false)
    policy_class_name ||=
      described_class.to_s.match(/(.+)Controller$/)[1].singularize + 'Policy'
    allow(policy_class_name.constantize).to receive(:new).and_return(policy)
  end
end

RSpec.configure do |config|
  config.include AuthorizationHelper, type: :controller
end
