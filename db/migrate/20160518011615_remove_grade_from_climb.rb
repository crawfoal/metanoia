class RemoveGradeFromClimb < ActiveRecord::Migration
  def change
    remove_column :climbs, :grade, :integer
  end
end
