class AddBucketIdToGrade < ActiveRecord::Migration
  def change
    add_reference :grades, :bucket, index: true, foreign_key: true
  end
end
