class SectionsController < ApplicationController
  def new
    authorize Section
    @gym_form = GymForm.new
  end

  def show
    @section = Section.find(params[:id])
  end
end
