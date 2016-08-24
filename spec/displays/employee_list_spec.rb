require 'rails_helper'

RSpec.describe EmployeeList do
  describe '#gym_name' do
    it 'returns the gym name' do
      gym = create :gym
      employee_list = EmployeeList.new(gym)

      expect(employee_list.gym_name).to eq gym.name
    end
  end

  describe '#employees' do
    it "includes of all of the gym's employees" do
      gym = create :gym, num_employees: 3
      employee_list = EmployeeList.new(gym)

      expect(employee_list.employees.size).to eq 3
    end

    it 'is enumerable and each item responds to :email and :roles' do
      gym = create :gym, num_employees: 3
      employee_list = EmployeeList.new(gym)

      employee_list.employees.each do |employee|
        expect(employee).to respond_to :email
        expect(employee).to respond_to :roles
      end
    end
  end
end
