require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#add_role' do
    it 'assigns the role to the user (smoke test for Rolify)' do
      user = create :user
      user.add_role :admin
      user.reload
      expect(user).to have_role :admin
    end

    it "sets the user's current role if it isn't already set" do
      user = create :user
      user.add_role :athlete
      user.reload
      expect(user.current_role).to eq 'athlete'
    end

    it "doesn't set the user's current role if it is already defined" do
      user = create :admin
      user.add_role :athlete
      user.reload
      expect(user.current_role).to eq 'admin'
    end
  end
end
