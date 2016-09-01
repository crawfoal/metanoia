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
    # Use `or` once upgraded to Rails 5 - I think then it could also be moved
    # to a scope in Grade called something like `with_null_bucket`. This could
    # then be used to clean up the spec a little too.
    Bucket.where(
      'buckets.grade_system_id = ? OR buckets.id = ?',
      @grade_system,
      Bucket.null_object
    ).
    joins(<<-SQL).
      LEFT JOIN (#{climbs_grades.to_sql}) climbs_grades
      ON buckets.id = climbs_grades.bucket_id
    SQL
    group('buckets.name').
    order('MIN(climbs_grades.sequence_number)').
    count('climbs_grades.id')
  end

  def grade_names_and_counts
    grades_with_null.
    joins(<<-SQL).
      LEFT JOIN (#{@climbs.to_sql}) climbs
      ON grades.id = climbs.grade_id
    SQL
    group('grades.name').
    order('MIN(grades.sequence_number)').
    count('climbs.id')
  end

  def climbs_grades
    grades_with_null.
    select('grades.bucket_id, grades.sequence_number, climbs.*').
    joins(<<-SQL)
      LEFT JOIN (#{@climbs.to_sql}) climbs
      ON grades.id = climbs.grade_id
    SQL
  end

  def grades_with_null
    # Use `or` once upgraded to Rails 5 - I think then it could also be moved
    # to a scope in Grade called something like `with_null_grade`. This could
    # then be used to clean up the spec a little too. We can also then replaces
    # this method with just directly calling that chain.
    Grade.where(
      'grades.grade_system_id = ? OR grades.id = ?',
      @grade_system,
      Grade.null_object
    )
  end
end
