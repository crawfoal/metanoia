require "#{Rails.root}/db/seeds/generators/bucket_generator"

class AddBucketsToYosemiteAndHueco
  def up
    generate_hueco_buckets
    generate_yds_buckets
  end

  def down
    GradeSystem.find_by_name('Hueco').buckets.destroy_all
    GradeSystem.find_by_name('Yosemite').buckets.destroy_all
  end

  private

  def generate_hueco_buckets
    BucketGenerator.new(
      grade_system: GradeSystem.find_by_name('Hueco'),
      bucket_names: [
        'V1 & ↓', 'V2 - V3', 'V4 - V5', 'V6 - V7', 'V8 - V9', 'V10 - V11',
        'V12 & ↑'
      ],
      bucket_sizes: {
        'V1 & ↓': 3,
        'V12 & ↑': 5,
        default: 2
      }
    ).generate
  end

  def generate_yds_buckets
    BucketGenerator.new(
      grade_system: GradeSystem.find_by_name('Yosemite'),
      bucket_names: ['5.7 & ↓'] + %w(5.8 5.9 5.10 5.11 5.12 5.13) + ['5.14 & ↑'],
      bucket_sizes: {
        '5.7 & ↓': 3,
        '5.8': 1,
        '5.9': 1,
        '5.14 & ↑': 8,
        default: 4
      }
    ).generate
  end
end
