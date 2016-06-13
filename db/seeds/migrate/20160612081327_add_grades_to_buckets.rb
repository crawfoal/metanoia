class AddGradesToBuckets
  def up
    Bucket.find_each do |bucket|
      lb_grade_sn = bucket.lower_bound_grade.sequence_number
      ub_grade_sn = bucket.upper_bound_grade.sequence_number
      bucket.grades = bucket.grade_system.grades.where(sequence_number: lb_grade_sn..ub_grade_sn)
    end
  end

  def down
    Bucket.find_each do |bucket|
      bucket.grades.delete_all
    end
  end
end
