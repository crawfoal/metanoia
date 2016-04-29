require 'rails_helper'

RSpec.shared_examples 'a gym policy for a non-admin user' do
  it { should forbid_new_and_create_actions }
  it { should forbid_edit_and_update_actions }
end

RSpec.describe GymPolicy do
  subject { GymPolicy.new(user, Gym) }

  context 'for a visitor' do
    let(:user) { nil }
    it_behaves_like 'a gym policy for a non-admin user'
  end

  context 'for a general user' do
    let(:user) { create :user }

    it_behaves_like 'a gym policy for a non-admin user'
  end

  context 'for an admin' do
    let(:user) { create :admin }

    it { should permit_new_and_create_actions }
    it { should permit_edit_and_update_actions }
  end

  context "for an admin who's current role isn't admin" do
    let(:user) do
      user = create :athlete
      user.add_role :admin
      user
    end
    it_behaves_like 'a gym policy for a non-admin user'
  end
end
