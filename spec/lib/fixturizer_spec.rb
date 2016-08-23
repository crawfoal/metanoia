require 'rails_helper'
require "#{Rails.root}/lib/fixturizer"

RSpec.describe Fixturizer, type: :concern do
  Climb.include Fixturizer

  describe '.to_fixtures' do
    it "returns a string containing the yaml representation of all the "\
       "records in the model's table" do
      section = create :section
      the_pearl = Climb.create!(
        grade: Grade.find_by_name!('V5'),
        type: 'Boulder',
        section: section
      )
      midnight_lightning = Climb.create!(
        grade: Grade.find_by_name!('V8'),
        type: 'Boulder',
        section: section
      )

      expect(Climb.to_fixtures).to eq \
%Q(---
climb_#{the_pearl.id}:
  id: #{the_pearl.id}
  color:\s
  type: Boulder
  section_id: #{section.id}
  grade_id: #{the_pearl.grade_id}
  teardown_date:\s
climb_#{midnight_lightning.id}:
  id: #{midnight_lightning.id}
  color:\s
  type: Boulder
  section_id: #{section.id}
  grade_id: #{midnight_lightning.grade_id}
  teardown_date:\s
)
    end
  end

  describe '.export_fixtures' do
    it 'creates (or re-creates) a file containing the tables fixtures, placing'\
       'the file in the specified directory' do
      delete_temporary_files
      dest_folder = "#{Rails.root}/tmp"

      Climb.export_fixtures into: dest_folder
      
      expect(File.read("#{dest_folder}/climbs.yml")).to \
        include Climb.to_fixtures
    end

    after(:each) { delete_temporary_files }
  end
end
