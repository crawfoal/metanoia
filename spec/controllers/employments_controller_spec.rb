require 'rails_helper'

RSpec.describe EmploymentsController, type: :controller do
  it do
    should route(:post, 'gyms/1/employees').to(action: :create, gym_id: 1)
  end

  it do
    should route(:get, 'gyms/1/employees').to(action: :index, gym_id: 1)
  end

  it 'should check authorization for #create' do
    user = create :manager
    gym = create :gym
    params = {
      employment_form: { email: user.email, role_name: 'manager' },
      gym_id: gym.id
    }
    pretend_not_authorized :create?
    xhr :post, :create, params
    expect_standard_not_authorized_response
  end

  it 'should check authorization for #index' do
    gym = create :gym
    pretend_not_authorized :index?
    get :index, { gym_id: gym.id }
    expect_standard_not_authorized_response
  end
end
