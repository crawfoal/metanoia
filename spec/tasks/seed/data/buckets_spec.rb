require 'rails_helper'

RSpec.describe 'Bucket seed data' do
  let(:grade_names_by_the_bucket) do
    gym.buckets.ordered.map { |bucket| bucket.grades.ordered.pluck(:name) }
  end

  let(:bucket_names) { gym.buckets.ordered.pluck(:name) }

  describe 'Hueco Buckets' do
    let(:gym) { GradeSystem.find_by_name('Hueco') }

    it 'should have the correct names' do
      expect(bucket_names).to eq [
        'V1 & ↓', 'V2 - V3', 'V4 - V5', 'V6 - V7', 'V8 - V9', 'V10 - V11',
        'V12 & ↑'
      ]
    end

    it 'should include the correct grades' do
      expect(grade_names_by_the_bucket).to eq [
        %w(VB V0 V1), %w(V2 V3), %w(V4 V5), %w(V6 V7), %w(V8 V9), %w(V10 V11),
        %w(V12 V13 V14 V15 V16)
      ]
    end
  end

  describe 'YDS Buckets' do
    let(:gym) { GradeSystem.find_by_name('Yosemite') }

    it 'should have the correct names' do
      expect(bucket_names).to eq \
        ['5.7 & ↓'] + %w(5.8 5.9 5.10 5.11 5.12 5.13) + ['5.14 & ↑']
    end

    it 'should include the correct grades' do
      expected = [%w(5.5 5.6 5.7)] + [['5.8'], ['5.9']]
      expected += (10..15).map do |decimal|
        %w(a b c d).map { |letter| "5.#{decimal}#{letter}" }
      end
      last_bucket = expected.pop(2).flatten
      last_bucket.pop
      expected += [last_bucket]
      expect(grade_names_by_the_bucket).to eq expected
    end
  end
end
