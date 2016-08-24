require 'rails_helper'

RSpec.describe ApplicationPolicy do
  it 'is initialized with an instance of Visitor if no user is given' do
    policy = ApplicationPolicy.new(nil, Gym) # e.g. current_user returns nil

    expect(policy.user).to be_instance_of Visitor
  end
end
