require 'rails_helper'

RSpec.describe EmployeesController, type: :controller do
  it do
    should route(:get, 'gyms/1/employees').to(action: :index, gym_id: 1)
  end
end
