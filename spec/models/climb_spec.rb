require 'rails_helper'

RSpec.describe Climb, type: :model do
  it { should validate_presence_of :type }
  it { should belong_to :section }
  it { should validate_presence_of :section }
  it { should have_one :gym }
  it { should belong_to :grade }

  it do
    should define_enum_for(:color).with([
      '#b71c1c', '#ec407a', '#7b1fa2', '#0d47a1', '#00838f', '#2e7d32',
      '#fdd835', '#ef6c00', '#6d4c41', '#000000', '#ffffff'
    ])
  end

  describe '.active' do
    it 'returns only climbs that have no teardown date, or have one in the future' do
      climb = create :climb
      old_climb = create :climb, :not_active

      expect(Climb.active.ids).to include climb.id
      expect(Climb.active.ids).to_not include old_climb.id
    end
  end

  describe '.color_name_for' do
    it 'returns the name of the color for the given hex code' do
      expect(Climb.color_name_for('#ec407a')).to eq 'pink'
    end

    it 'returns nil if the given hex code is not in the colors enum list' do
      expect(Climb.color_name_for('#abcdef')).to be_nil
    end
  end

  describe 'the climb factory' do
    it 'should not create an extra section when we build a climb and add it to'\
       ' an existing section' do
       section = create :section
       section.climbs << build(:climb)
       section.save!

       expect(Section.count).to eq 1
    end
  end

  describe '#set_grade_default_if_blank' do
    it 'when no grade is specified for the climb, it is assigned the null '\
       'grade object' do
      climb = create :climb, grade: nil

      expect(climb.grade).to eq Grade.null_object
    end
  end
end
