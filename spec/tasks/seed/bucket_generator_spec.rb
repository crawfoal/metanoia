require 'rails_helper'
require "#{Rails.root}/lib/tasks/seed/bucket_generator"

RSpec.describe BucketGenerator do
  describe '#generate' do
    xit 'properly generates the buckets' do
      yds = GradeSystem.find_by_name 'Yosemite'
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
      expect(yds.reload.buckets.ordered.map(&:name)).to eq bucket_names
    end
  end
end
