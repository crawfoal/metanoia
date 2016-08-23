require 'rails_helper'

RSpec.describe Employment, type: :model do
  it { should belong_to :gym }
  it { should belong_to :role_story }
  it { should validate_presence_of :gym }
  it { should validate_presence_of :role_story }

  it 'validates presence of gym at the database level' do
    employment = build :employment, gym: nil

    expect { employment.save!(validate: false) }.to \
      raise_error(/.*null value in column "gym_id"/)
  end

  it 'validates presence of role_story at the database level' do
    employment = build :employment, :without_role_story

    expect { employment.save!(validate: false) }.to \
      raise_error(/.*null value in column "role_story_id"/)
  end

  describe '.roles' do
    it 'includes all roles that can be chosen for the employment' do
      expect(Employment.roles).to include :setter, :manager
    end
  end

  describe '#user' do
    it 'returns the user via with the role_story' do
      setter = create :setter
      employment = build :employment, role_story: setter.setter_story

      expect(employment.user).to eq setter
    end
  end

  describe '#role_name' do
    it 'returns the name of the role that is associated to the employment '\
       'record' do
      employment = build :employment, role_story: create(:setter).setter_story

      expect(employment.role_name).to eq 'setter'
    end
  end
end
