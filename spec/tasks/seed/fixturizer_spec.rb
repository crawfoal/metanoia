require 'rails_helper'
require "#{Rails.root}/lib/tasks/seed/fixturizer"

RSpec.describe Fixturizer, type: :concern do
  Climb.include Fixturizer

  describe '.to_fixtures' do
    it "returns a string containing the yaml representation of all the "\
       "records in the model's table" do
      section = create :section
      the_pearl = Climb.create!(
        grade: 'V5',
        type: 'Boulder',
        section: section
      )
      midnight_lightning = Climb.create!(
        grade: 'V8',
        type: 'Boulder',
        section: section
      )

      expect(Climb.to_fixtures).to eq \
%Q(---
climb_#{the_pearl.id}:
  id: #{the_pearl.id}
  color:\s
  type: Boulder
  grade: #{the_pearl.attributes['grade']}
  section_id: #{section.id}
climb_#{midnight_lightning.id}:
  id: #{midnight_lightning.id}
  color:\s
  type: Boulder
  grade: #{midnight_lightning.attributes['grade']}
  section_id: #{section.id}
)
    end
  end

  describe '.export_fixtures' do
    it 'creates (or re-creates) a file containing the tables fixtures, placing'\
       'the file in the specified directory' do
      delete_temporary_files
      dest_folder = "#{Rails.root}/tmp"
      Climb.export_fixtures into: dest_folder
      expect(File.read("#{dest_folder}/climbs.yml")).to include Climb.to_fixtures
    end

    after(:each) { delete_temporary_files }
  end
end
