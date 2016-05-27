class ChangeRouteGradeSystemToNullFalse < ActiveRecord::Migration
  def change
    change_column_null(:gyms, :route_grade_system_id, false, 4)
  end
end
