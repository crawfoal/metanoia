class EmploymentsController < ApplicationController
  # TODO: check authorization

  def index
    @gym = Gym.find(params[:gym_id])
    @employment_form = EmploymentForm.new
  end

  def create
    @employment_form = EmploymentForm.new(employment_form_params)
    if @employment_form.save
      flash.now[:notice] = "New #{@employment_form.role_name} successfully added!"
    end
  end

  private

  def employment_form_params
    params.
      require(:employment).
      permit(:email, :role_name).
      merge(gym_id: params[:gym_id])
  end
end
