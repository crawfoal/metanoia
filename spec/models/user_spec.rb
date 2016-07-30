require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_one :athlete_story }
  it { should have_one :setter_story }
  it { should have_one :manager_story }

  describe '#add_role' do
    it 'assigns the role to the user' do
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

    it 'creates an associated story record' do
      user = create :athlete
      expect(user.athlete_story).to be_present
    end
  end

  describe '#add_role' do
    let(:gym) { create :gym }
    let(:setter) { create :setter, employed_at: gym }

    it 'returns true if the user is employed at that gym with that role' do
      expect(setter.employed_at? gym, with_role: 'setter').to be true
    end

    it 'returns false if the user is not employed at that gym with that role' do
      expect(setter.employed_at? gym, with_role: 'manager').to be false
    end
  end
end
