class ClimbsController < ApplicationController
  before_action(only: [:new, :create, :update]) { authorize Climb }

  def new
    @climb = Climb.new
    @climb.section_id = params[:section_id]
  end

  def create
    @climb = Climb.new(climb_params)
    @climb.section_id = params[:section_id]
    if @climb.save
      flash.now[:notice] = 'Climb successfully saved!'
    else
      render :new
    end
  end

  private

  def climb_params
    params.require(:climb).permit(
      :section_id,
      :color,
      :type,
      :grade_id,
      :teardown_date
    )
  end
end
