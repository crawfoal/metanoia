class BucketGenerator
  def initialize(grade_system:, bucket_names:, bucket_sizes:)
    @grade_system = grade_system
    @bucket_names = bucket_names
    bucket_sizes.default = bucket_sizes.delete(:default)
    @bucket_sizes = bucket_sizes
    @grades = @grade_system.grades.ordered.to_a
  end

  def generate
    @bucket_names.each do |bucket_name|
      grades_in_this_bucket = @grades.shift(@bucket_sizes[bucket_name.to_sym])
      Bucket.create!(
        name: bucket_name,
        grade_system: @grade_system,
        lower_bound_grade: grades_in_this_bucket.first,
        upper_bound_grade: grades_in_this_bucket.last,
        grades: grades_in_this_bucket
      )
    end
  end
end
