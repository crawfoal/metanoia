class AddForeignKeyBoulderGradeSystemToGym < ActiveRecord::Migration
  def change
    add_foreign_key :gyms, :grade_systems, column: :boulder_grade_system_id
  end
end
