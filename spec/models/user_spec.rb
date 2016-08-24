require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_one :athlete_story }
  it { should have_one :setter_story }
  it { should have_one :manager_story }

  describe '#add_role' do
    it 'assigns the role to the user' do
      user = build :user

      expect { user.add_role :admin }.to \
        change { user.has_role? :admin }.to(true)
    end

    it "sets the user's current role if it isn't already set" do
      user = build :user

      expect { user.add_role :athlete }.to \
        change { user.current_role }.to('athlete')
    end

    it "doesn't set the user's current role if it is already defined" do
      user = build :athlete

      expect { user.add_role :admin }.to_not change { user.current_role }
    end

    it 'creates an associated story record' do
      user = build :user

      expect { user.add_role :athlete }.to \
        change { user.athlete_story.present? }.to(true)
    end

    context "the role isn't already defined" do
      it "doesn't change the user's current role" do
        user = build :user

        expect { user.add_role :fake }.to_not change { user.current_role }
      end

      it "doesn't define a new role record" do
        user = build :user

        expect { user.add_role :fake }.to_not change { Role.count }
      end
    end
  end

  describe '#employed_at?' do
    it 'returns true if the user is employed at that gym with that role' do
      gym = create :gym
      setter = create :setter, employed_at: gym

      expect(setter.employed_at?(gym, with_role: 'setter')).to be true
    end

    it 'returns false if the user is employed at that gym, but not with that '\
       'role' do
      gym = create :gym
      setter = create :setter, employed_at: gym

      expect(setter.employed_at?(gym, with_role: 'manager')).to be false
    end
  end
end
