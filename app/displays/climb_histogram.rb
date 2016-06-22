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

  def grade_names_and_counts
    grade_ids_and_names.map do |grade_id, name|
      [name, counts_by_grade_id[grade_id] || 0]
    end
  end

  def bucket_names_and_counts
    bucket_names_and_grades.map do |name, grades|
      bucket_count = grades.reduce(0) do |sum, grade|
        sum + (counts_by_grade_id[grade.id] || 0)
      end
      [name, bucket_count]
    end
  end

  def bucket_names_and_grades
    @grade_system.buckets.includes(:grades).map do |bucket|
      [bucket.name, bucket.grades]
    end
  end

  def counts_by_grade_id
    @_cbg ||= @climbs.joins(:grade).group(:grade_id).count
  end

  def grade_ids_and_names
    @_gin ||= grades.pluck(:id, :name) + Grade.null_object.pluck(:id, :name)
  end

  def grades
    @_grades ||= Grade.where(grade_system_id: @grade_system.id).ordered
  end
end
