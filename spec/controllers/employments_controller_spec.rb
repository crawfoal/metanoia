require 'rails_helper'

RSpec.describe EmploymentsController, type: :controller do
  it do
    should route(:post, 'gyms/1/employees').to(action: :create, gym_id: 1)
  end

  it do
    should route(:get, 'gyms/1/employees').to(action: :index, gym_id: 1)
  end

  it 'should check authorization for #create' do
    params = {
      employment_form: { email: 'email@example.com', role_name: 'manager' },
      gym_id: 1
    }
    pretend_not_authorized :create?

    post :create, xhr: true, params: params

    expect_standard_not_authorized_response
  end

  it 'should check authorization for #index' do
    gym = build_stubbed :gym
    allow(Gym).to receive(:find).with(gym.id.to_s).and_return(gym)
    pretend_not_authorized :index?, 'EmployeeListPolicy'

    get :index, params: { gym_id: gym.id }

    expect_standard_not_authorized_response
  end

  describe '#create' do
    it 'cannot create new roles' do
      athlete = create :athlete
      gym = create :gym
      params = {
        employment_form: { email: athlete.email, role_name: 'faker' },
        gym_id: gym.id
      }
      pretend_authorized :create?

      expect { post :create, xhr: true, params: params }.to_not change \
        { Role.count }
    end
  end
end
