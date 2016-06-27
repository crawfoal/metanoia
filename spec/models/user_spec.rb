require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_one :athlete_story }
  it { should have_one :setter_story }

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

    context 'the role is :athlete' do
      it 'creates an associated athlete_story record' do
        user = create :athlete
        expect(user.athlete_story).to be_present
      end
    end

    context 'the role is :setter' do
      it 'creates an associated setter_story record' do
        user = create :setter
        expect(user.setter_story).to be_present
      end
    end
  end
end
