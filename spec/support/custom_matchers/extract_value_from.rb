RSpec::Matchers.define :extract_value_from do |*expected|
  options = expected.extract_options!
  attributes = expected
  collections = Array(options[:collections])

  match do |actual|
    all_attributes_listed = attributes.all? do |attribute_name|
      actual.class.attributes_to_extract.include? attribute_name
    end
    all_collections_listed = collections.all? do |collection_name|
      actual.class.collections_to_extract.include? collection_name
    end

    all_attributes_listed && all_collections_listed
  end
end
