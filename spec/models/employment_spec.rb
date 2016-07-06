require 'rails_helper'

RSpec.describe Employment, type: :model do
  it { should belong_to :gym }
  it { should belong_to :role_story }

  let(:setter) { create :setter }
  let(:gym) { create :gym }

  describe '.roles' do
    it 'includes all roles that can be chosen for the employment' do
      expect(Employment.roles).to include :setter, :manager
    end
  end

  describe '#user' do
    it 'returns the user via with the role_story' do
      employment = gym.employments.create(role_story: setter.setter_story)
      expect(employment.user).to eq setter
    end
  end

  describe '#role_name' do
    it 'returns the name of the role that is associated to the employment record' do
      employment = gym.employments.create(role_story: setter.setter_story)
      expect(employment.role_name).to eq 'setter'
    end
  end
end
