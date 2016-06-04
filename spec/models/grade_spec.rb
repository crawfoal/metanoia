require 'rails_helper'

RSpec.describe Grade, type: :model do
  it { should belong_to :grade_system }
  it { should validate_presence_of :name }
  it { should validate_presence_of :grade_system }

  describe '.null_object' do
    it 'returns the null object for the grade model' do
      expect(Grade.null_object).to eq \
        GradeSystem.find_by_name('Null Grade System').grades.first
    end
  end
end
