require 'rails_helper'

RSpec.describe EmploymentsController, type: :controller do
  it do
    should route(:post, 'gyms/1/employees').to(action: :create, gym_id: 1)
  end

  it do
    should route(:get, 'gyms/1/employees').to(action: :index, gym_id: 1)
  end
end
