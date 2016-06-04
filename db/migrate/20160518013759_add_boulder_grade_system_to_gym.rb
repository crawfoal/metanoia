class AddBoulderGradeSystemToGym < ActiveRecord::Migration
  def change
    add_reference :gyms, :boulder_grade_system, index: true
  end
end
