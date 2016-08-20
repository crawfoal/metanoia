class SectionsController < ApplicationController
  def new
    authorize Section
    @gym_form = GymForm.new
    @gym_form.add_section
  end

  def show
    @section = Section.find(params[:id])
  end
end
