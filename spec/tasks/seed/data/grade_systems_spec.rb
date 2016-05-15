require 'rails_helper'

RSpec.describe 'GradeSystem seed data' do
  describe 'Hueco Scale' do
    it 'exists' do
      expect(GradeSystem.find_by_name 'Hueco').to be_present
    end

    it 'has all of the grades defined' do
      hueco_scale = GradeSystem.find_by_name 'Hueco'
      expect(hueco_scale.grades.map(&:name)).to \
        eq %w(VB V0 V1 V2 V3 V4 V5 V6 V7 V8 V9 V10 V11 V12 V13 V14 V15 V16)
    end
  end
end
