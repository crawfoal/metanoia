class ChangeClimbGradeDefault < ActiveRecord::Migration
  def change
    change_column_default(:climbs, :grade_id, 111)
  end
end
