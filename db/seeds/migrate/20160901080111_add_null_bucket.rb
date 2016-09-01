class AddNullBucket
  def up
    null_grade_system = GradeSystem.find_by_name('Null Grade System')
    null_bucket = Bucket.create!(
      grade_system: null_grade_system,
      name: '?'
    )
    Grade.null_object.update!(bucket: null_bucket)
  end

  def down
    null_grade = Grade.null_object
    null_bucket = null_grade.bucket
    null_grade.update!(bucket: nil)
    null_bucket.destroy!
  end
end
