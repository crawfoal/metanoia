class RemoveUpperBoundGradeIdFromBucket < ActiveRecord::Migration
  def change
    remove_column :buckets, :upper_bound_grade_id, :integer
  end
end
