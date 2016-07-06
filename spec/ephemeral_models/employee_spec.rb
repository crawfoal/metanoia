require 'rails_helper'

RSpec.describe Employee do
  let(:employee) { Employee.new(email: 'amanda@example.com', roles: ['setter', 'manager']) }

  it 'should have an email attribute' do
    expect(employee.email).to eq 'amanda@example.com'
  end

  it 'should have a roles attribute' do
    expect(employee.roles).to eq ['setter', 'manager']
  end

  describe '#roles=' do
    it 'should update the list of roles' do
      employee.roles = 'coach'
      expect(employee.roles).to eq 'coach'
    end
  end

  describe '#initialize' do
    it 'can take an object that responds to `email` and `role_name`' do
      employment_form = EmploymentForm.new(email: 'amanda@example.com', role_name: 'setter')
      employee = Employee.new(employment_form)
      expect(employee.email).to eq 'amanda@example.com'
      expect(employee.roles).to eq 'setter'
    end
  end
end
