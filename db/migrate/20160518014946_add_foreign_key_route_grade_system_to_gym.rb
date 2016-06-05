class AddForeignKeyRouteGradeSystemToGym < ActiveRecord::Migration
  def change
    add_foreign_key :gyms, :grade_systems, column: :route_grade_system_id
  end
end
