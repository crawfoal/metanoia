class SectionsController < ApplicationController
  def new
    authorize Section
    @gym_form = GymForm.new
    @gym_form.add_section
  end

  def show
    @section = Section.includes(:gym).find(params[:id])
  end
end
