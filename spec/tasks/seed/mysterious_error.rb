require 'rails_helper'

RSpec.describe 'Hueco and one Yosemite grade systems' do
  # Somehow duplicate records were created, and I couldn't determine the cause,
  # I checked `rake db:seed`, `rake db:populate` (which runs db:reset as well),
  # and I verified that the specs weren't creating these duplicate records. This
  # spec is here so that we can know as soon as possible that a duplicate record
  # was created and hopefullly get a better idea of what caused it.
  it 'should not be duplicated' do
    expect(GradeSystem.find_by_name('Hueco').count).to eq 1
    expect(GradeSystem.find_by_name('Yosemite').count).to eq 1
  end
end
