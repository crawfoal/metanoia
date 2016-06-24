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

  # TODO: Handle a failure to update. Should flash something, and make sure that
  # the climb isn't removed from the page. Right now, it silently fails. The
  # climb will be removed from the page, but the next time the section is
  # loaded, the climb will show up again.
  def update
    @climb = Climb.find(params[:id])
    @climb.update(climb_params)
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
