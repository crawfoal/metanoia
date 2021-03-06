class EmploymentsController < ApplicationController
  def index
    @employment_form = EmploymentForm.new(gym_id: params[:gym_id])
    @employee_list = EmployeeList.new(Gym.find(params[:gym_id]))
    authorize @employee_list
  end

  def create
    @employment_form = EmploymentForm.new(employment_form_params)
    authorize @employment_form.employment
    if @employment_form.save
      @employee = @employment_form.to_employee
      flash.now[:notice] =
        "New #{@employment_form.role_name} successfully added!"
      @employment_form = EmploymentForm.new(gym_id: params[:gym_id])
    else
      render :new
    end
  end

  private

  def employment_form_params
    params.
      require(:employment_form).
      permit(:email, :role_name).
      merge(gym_id: params[:gym_id])
  end
end
