require 'rails_helper'

RSpec.describe Employee do
  describe '#roles' do
    it 'looks up the roles that the user has as an employee at the given gym' do
      user = create :setter
      gym = create :gym
      gym.employments.create!(role_story: user.setter_story)
      EmploymentForm.new(
        email: user.email,
        role_name: 'manager',
        gym_id: gym.id
      ).save!
      employee = Employee.new(email: user.email, gym_id: gym.id)
      expect(employee.roles).to include 'setter', 'manager'
    end

    it "doesn't error if the user doesn't have a certain role" do
      user = create :setter
      gym = create :gym
      gym.employments.create!(role_story: user.setter_story)
      employee = Employee.new(email: user.email, gym_id: gym.id)
      expect { employee.roles }.to_not raise_error
    end
  end
end
