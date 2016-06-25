class EmployeesController < ApplicationController
  # TODO: check authorization

  def index
    @gym = Gym.find(params[:gym_id])
  end
end
