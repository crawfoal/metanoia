class ClimbsController < ApplicationController
  def new
    @climb = Climb.new
  end

  def create
    @climb = Climb.new(climb_params)
    if @climb.save
      flash.now[:notice] = "Climb successfully saved!"
    else
      render :new
    end
  end

  private

  def climb_params
    params.require(:climb).permit(:section_id, :color, :type, :grade)
  end
end
