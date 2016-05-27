class AddRouteGradeSystemToGym < ActiveRecord::Migration
  def change
    add_reference :gyms, :route_grade_system, index: true
  end
end
