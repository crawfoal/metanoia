class EmploymentsController < ApplicationController
  def create
    @employment = Employment.new(employment_params)
    if @employment.save
      flash.now[:notice] = "New #{@employment.role_name} successfully added!"
    end
  end

  private

  def employment_params
    params.
      require(:employment).
      permit(:email, :role_name).
      merge(gym_id: params[:gym_id])
  end
end
