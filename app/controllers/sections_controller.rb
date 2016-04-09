class SectionsController < ApplicationController
  def new
    @gym_form = Forms::Gym.new
  end
end
