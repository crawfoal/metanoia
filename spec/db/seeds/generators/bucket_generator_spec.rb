require 'rails_helper'
require "#{Rails.root}/db/seeds/generators/bucket_generator"

RSpec.describe BucketGenerator do
  describe '#generate' do
    it 'generates buckets with the correct names, and includes every grade in '\
       'a bucket' do
      yds = GradeSystem.find_by_name 'Yosemite'
      yds.buckets.each { |bucket| bucket.grades.delete_all } # just nullifies
      yds.buckets.destroy_all

      bucket_names = ['5.7 & ↓'] + %w(5.8 5.9 5.10 5.11 5.12 5.13) + ['5.14 & ↑']
      BucketGenerator.new(
        grade_system: yds,
        bucket_names: bucket_names,
        bucket_sizes: {
          '5.7 & ↓': 3,
          '5.8': 1,
          '5.9': 1,
          '5.14 & ↑': 8,
          default: 4
        }
      ).generate

      yds.reload
      expect(yds.buckets.ordered.map(&:name)).to eq bucket_names
      expect(yds.buckets.map(&:grades).flatten.size).to eq yds.grades.size
    end
  end
end
