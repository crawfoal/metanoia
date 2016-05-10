require 'rails_helper'

RSpec.describe 'db:seed' do
  it 'destroys all existing records from the seeded tables' do
    grade_system = GradeSystem.create name: 'I should be deleted'
    grade = Grade.create(
      name: 'I should be deleted',
      order: 1,
      grade_system: grade_system
    )

    Rails.application.load_seed

    expect(GradeSystem.find_by_name 'I should be deleted').to_not be_present
    expect(Grade.find_by_name 'I should be deleted').to_not be_present
  end

  describe 'Hueco Scale' do
    it 'is defined' do
      expect(GradeSystem.find_by_name 'Hueco Scale').to be_present
    end

    it 'has the appropriate associated grades' do
      expect(GradeSystem.find_by_name('Hueco Scale').grades.map(&:name)).to \
        eq %w(VB V0 V1 V2 V3 V4 V5 V6 V7 V8 V9 V10 V11 V12 V13 V14 V15 V16)
    end
  end

  describe 'YDS' do
    it 'is defined' do
      expect(GradeSystem.find_by_name('YDS')).to be_present
    end

    it 'has the appropriate associated grades' do
      expect(GradeSystem.find_by_name('YDS').grades.map(&:name)).to eq %w(
        5.5 5.6 5.7 5.8 5.9 5.10a 5.10b 5.10c 5.10d
        5.11a 5.11b 5.11c 5.11d 5.12a 5.12b 5.12c 5.12d
        5.13a 5.13b 5.13c 5.13d 5.14a 5.14b 5.14c 5.14d
        5.15a 5.15b 5.15c
      )
    end
  end
end
