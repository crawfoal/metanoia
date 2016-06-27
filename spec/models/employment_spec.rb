require 'rails_helper'

RSpec.describe Employment, type: :model do
  it { should belong_to :gym }
  it { should belong_to :role_story }

  let(:setter) { create :setter }
  let(:gym) { create :tiny_route_gym }
  let(:employment) { gym.employments.create(role_story: setter.setter_story) }

  describe '::ROLES' do
    it 'includes all roles that can be chosen for the employment' do
      expect(Employment::ROLES).to include :setter
    end
  end

  describe '#user' do
    it 'returns the user via with the role_story' do
      expect(employment.user).to eq setter
    end
  end

  describe '#role_name' do
    it 'returns the role name for the associated `role_story`' do
      expect(employment.role_name).to eq 'setter'
    end
  end

  describe '#email' do
    it "returns the associated user's email" do
      expect(employment.email).to eq setter.email
    end
  end

  describe 'before_save callback, #role_name= and #email=' do
    it 'associates the correct role_story based on role and email virtual attributes' do
      this_employment = Employment.create(email: setter.email, role_name: 'setter')
      expect(this_employment.role_story).to eq setter.setter_story
    end

    it 'does nothing if the email or role_name are not set' do
      this_employment = Employment.create
      expect(this_employment.role_story).to be_nil
    end

    it 'does nothing if the email and role_name have not changed' do
      this_employment = Employment.create(email: setter.email, role_name: 'setter')
      another_instance = Employment.last
      expect(User).to_not receive :find_by_email
      another_instance.save
    end
  end
end
