module AuthorizationHelper
  def expect_standard_not_authorized_response
    expect(flash[:alert]).to eq 'You are not authorized to perform this action.'
    expect(response).to redirect_to root_path
  end

  def pretend_not_authorized(authorization_method_name, policy_class_name = nil)
    policy = double(authorization_method_name => false)
    fake_policy_construction(policy, policy_class_name)
  end

  def pretend_authorized(authorization_method_name, policy_class_name = nil)
    policy = double(authorization_method_name => true)
    fake_policy_construction(policy, policy_class_name)
  end

  private

  def fake_policy_construction(fake, policy_class_name = nil)
    policy_class_name ||=
      described_class.to_s.match(/(.+)Controller$/)[1].singularize + 'Policy'
    allow(policy_class_name.constantize).to receive(:new).and_return(fake)
  end
end

RSpec.configure do |config|
  config.include AuthorizationHelper, type: :controller
end
