require 'rails_helper'

RSpec.describe GradeSystem, type: :model do
  it { should have_many :grades }
  it { should validate_presence_of :name }
  it { should have_many :buckets }

  describe 'has_buckets?' do
    it 'returns false if there are no associated buckets' do
      expect(GradeSystem.find_by_name('Rainbow Scale').has_buckets?).to be false
    end

    it 'returns true if there are associated buckets' do
      expect(GradeSystem.find_by_name('Hueco').has_buckets?).to be true
    end
  end
end
