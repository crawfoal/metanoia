class ChangeClimbGradeNull < ActiveRecord::Migration
  def change
    change_column_null(:climbs, :grade_id, false, Grade.find_by_name('?').id)
  end
end
