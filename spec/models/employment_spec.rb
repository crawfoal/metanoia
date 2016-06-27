require 'rails_helper'

RSpec.describe Employment, type: :model do
  it { should belong_to :gym }
  it { should belong_to :role_story }

  describe '#user' do
    it 'returns the user via with the role_story' do
      user = create :setter
      gym = create :tiny_route_gym
      gym.employments.create(role_story: user.setter_story)
      expect(user.setter_story.employments.first.user).to eq user
    end
  end
end
