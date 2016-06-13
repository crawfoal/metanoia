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
      Bucket.create!(
        name: bucket_name,
        grade_system: @grade_system,
        grades: @grades.shift(@bucket_sizes[bucket_name.to_sym])
      )
    end
  end
end
