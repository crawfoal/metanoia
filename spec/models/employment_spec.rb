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

  describe '#roles_for' do
    it 'returns the role names for all of a users employments' do
      user = create :setter
      setter_employment = create :employment, role_story: user.setter_story
      user.add_role :manager
      create :employment,
             gym: setter_employment.gym,
             role_story: user.manager_story

      expect(Employment.roles_for(user)).to include 'setter', 'manager'
    end
  end

  describe '.for_user' do
    it 'returns all employment records for the specified user' do
      user = create :setter
      setter_employment = create :employment, role_story: user.setter_story
      user.add_role :manager
      manager_employment = create :employment,
                                  gym: setter_employment.gym,
                                  role_story: user.manager_story

      expect(Employment.for_user(user)).to include \
        setter_employment, manager_employment
    end

    it 'accepts both user object and user id' do
      user = create(:setter)
      employment = create :employment, role_story: user.setter_story

      expect(Employment.for_user(user).first).to eq employment
      expect(Employment.for_user(user.id).first).to eq employment
    end
  end
end
