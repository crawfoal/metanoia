require 'rails_helper'

RSpec.describe EmployeeList do
  let(:gym) { create :gym }
  let(:employee_list) { EmployeeList.new(gym) }

  describe '#gym_name' do
    it 'returns the gym name' do
      expect(employee_list.gym_name).to eq gym.name
    end
  end

  describe '#employees' do
    before :each do
      create_list :setter, 3, employed_at: {name: gym.name}
    end

    it "includes of all of the gym's employees" do
      expect(employee_list.employees.size).to eq 3
    end

    it "is enumerable and each item responds to :email and :roles" do
      employee_list.employees.each do |employee|
        expect(employee).to respond_to :email
        expect(employee).to respond_to :roles
      end
    end
  end
end
