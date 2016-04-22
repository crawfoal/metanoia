RSpec::Matchers.define :have_section_named do |expected|
  match do |actual|
    actual.sections.map(&:name).include? expected
  end
end

RSpec::Matchers.define :have_sections_named do |*expected|
  match do |actual|
    section_names = actual.sections.map(&:name)
    expected.all? { |expected_name| section_names.include? expected_name }
  end
end
