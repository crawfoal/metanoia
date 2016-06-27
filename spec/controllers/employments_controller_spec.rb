require 'rails_helper'

RSpec.describe EmploymentsController, type: :controller do
  it do
    should route(:post, 'gyms/1/employments').to(action: :create, gym_id: 1)
  end
end
