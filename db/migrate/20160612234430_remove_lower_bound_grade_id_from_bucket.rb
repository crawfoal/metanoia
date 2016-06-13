class RemoveLowerBoundGradeIdFromBucket < ActiveRecord::Migration
  def change
    remove_column :buckets, :lower_bound_grade_id, :integer
  end
end
