class ResetsController < ApplicationController
  def create
    Section.find(params[:section_id]).climbs.
      update_all(teardown_date: DateTime.current)
  end
end
