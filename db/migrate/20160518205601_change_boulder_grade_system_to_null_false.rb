class ChangeBoulderGradeSystemToNullFalse < ActiveRecord::Migration
  def change
    change_column_null(:gyms, :boulder_grade_system_id, false, 2)
  end
end
