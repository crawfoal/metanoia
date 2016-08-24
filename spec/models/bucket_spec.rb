require 'rails_helper'

RSpec.describe Bucket, type: :model do
  it { should belong_to :grade_system }
  it { should have_many(:grades) }

  describe '.ordered' do
    it "should order the buckets according the contained grades' "\
       "`sequence_number`" do
      hueco_buckets = Bucket.where(
        grade_system: GradeSystem.find_by_name('Hueco')
      )

      expect(hueco_buckets.ordered.map(&:name)).to eq \
        ['V1 & ↓', 'V2 - V3', 'V4 - V5', 'V6 - V7', 'V8 - V9', 'V10 - V11',
         'V12 & ↑']
    end
  end
end
