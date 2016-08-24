require 'rails_helper'

RSpec.describe 'Bucket seed data' do
  m = Module.new

  class m::GradeSystemDecorator < SimpleDelegator
    def bucket_names
      buckets.ordered.map(&:name)
    end

    def grade_names_by_the_bucket
      buckets.ordered.map { |bucket| bucket.grades.ordered.pluck(:name) }
    end
  end

  describe 'Hueco Buckets' do
    it 'should have the correct names' do
      gs = m::GradeSystemDecorator.new(GradeSystem.find_by_name('Hueco'))

      expect(gs.bucket_names).to eq [
        'V1 & ↓', 'V2 - V3', 'V4 - V5', 'V6 - V7', 'V8 - V9', 'V10 - V11',
        'V12 & ↑'
      ]
    end

    it 'should include the correct grades' do
      gs = m::GradeSystemDecorator.new(GradeSystem.find_by_name('Hueco'))

      expect(gs.grade_names_by_the_bucket).to eq [
        %w(VB V0 V1), %w(V2 V3), %w(V4 V5), %w(V6 V7), %w(V8 V9), %w(V10 V11),
        %w(V12 V13 V14 V15 V16)
      ]
    end
  end

  describe 'YDS Buckets' do
    it 'should have the correct names' do
      gs = m::GradeSystemDecorator.new(GradeSystem.find_by_name('Yosemite'))

      expect(gs.bucket_names).to eq \
        ['5.7 & ↓'] + %w(5.8 5.9 5.10 5.11 5.12 5.13) + ['5.14 & ↑']
    end

    it 'should include the correct grades' do
      gs = m::GradeSystemDecorator.new(GradeSystem.find_by_name('Yosemite'))

      expect(gs.grade_names_by_the_bucket).to eq \
        [%w(5.5 5.6 5.7), ['5.8'], ['5.9'], %w(5.10a 5.10b 5.10c 5.10d),
         %w(5.11a 5.11b 5.11c 5.11d), %w(5.12a 5.12b 5.12c 5.12d),
         %w(5.13a 5.13b 5.13c 5.13d),
         %w(5.14a 5.14b 5.14c 5.14d 5.15a 5.15b 5.15c)]
    end
  end
end
