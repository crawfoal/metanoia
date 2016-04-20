require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#add_role' do
    it 'assigns the role to the user (smoke test for Rolify)' do
      user = build :user
      user.add_role :admin
      expect(user).to have_role :admin
    end
  end
end
