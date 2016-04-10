RSpec::Matchers.define :extract_value_from do |*expected|
  options = expected.extract_options!
  attributes = expected
  collections = Array(options[:collections])

  match do |actual|
    attributes.all? do |attribute_name|
      actual.class.attributes_to_extract.include? attribute_name
    end and
    collections.all? do |collection_name|
      actual.class.collections_to_extract.include? collection_name
    end
  end
end
