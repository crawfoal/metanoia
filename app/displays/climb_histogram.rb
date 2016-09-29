class ClimbHistogram
  def initialize(climbs, grade_system)
    @climbs = climbs
    @grade_system = grade_system
  end

  def data
    if @grade_system.has_buckets?
      bucket_names_and_counts
    else
      grade_names_and_counts
    end
  end

  def has_data?
    @climbs.exists?
  end

  private
  def bucket_names_and_counts
    Bucket.null_or_where(grade_system: @grade_system).
    left_join_subquery(climbs_grades, :climbs_grades).
    group('buckets.name').
    order('MIN(climbs_grades.sequence_number)').
    count('climbs_grades.id')
  end

  def grade_names_and_counts
    grades_with_null.
    left_join_subquery(@climbs, :climbs).
    group('grades.name').
    order('MIN(grades.sequence_number)').
    count('climbs.id')
  end

  def climbs_grades
    grades_with_null.
    left_join_subquery(@climbs, :climbs).
    select('grades.bucket_id, grades.sequence_number, climbs.*')
  end

  def grades_with_null
    Grade.null_or_where(grade_system: @grade_system)
  end
end
