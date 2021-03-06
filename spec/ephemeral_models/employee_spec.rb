require 'rails_helper'

RSpec.describe Employee do
  describe '#roles_in_words' do
    it 'looks up the roles that the user has as an employee at the given gym' do
      gym = create :gym
      user = create :setter, employed_at: gym
      create :employment_form, email: user.email, role_name: 'manager', gym: gym
      employee = Employee.new(email: user.email, gym_id: gym.id)

      expect(employee.roles_in_words).to include 'setter', 'manager'
    end

    it "doesn't error if the user doesn't have a certain role" do
      gym = create :gym
      user = create :setter, employed_at: gym
      employee = Employee.new(email: user.email, gym_id: gym.id)

      expect { employee.roles_in_words }.to_not raise_error
    end
  end

  describe '#roles' do
    it 'returns an array of the role names' do
      gym = create :gym
      user = create :setter, employed_at: gym
      create :employment_form, email: user.email, role_name: 'manager', gym: gym
      employee = Employee.new(email: user.email, gym_id: gym.id)

      expect(employee.roles).to include 'setter', 'manager'
    end
  end
end
