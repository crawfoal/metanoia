require 'rails_helper'

RSpec.describe Employment, type: :model do
  it { should belong_to :gym }
  it { should belong_to :role_story }

  describe '::ROLES' do
    it 'includes all roles that can be chosen for the employment' do
      expect(Employment::ROLES).to include :setter
    end
  end

  describe '#user' do
    it 'returns the user via with the role_story' do
      setter = create :setter
      gym = create :tiny_route_gym
      employment = gym.employments.create(role_story: setter.setter_story)
      expect(employment.user).to eq setter
    end
  end
end
