module ExtractValue
  extend ActiveSupport::Concern

  def value(options = {})
    value = values_for_attributes(options).merge(values_for_collections(options))
    value.blank? ? nil : value
  end

  module ClassMethods
    def extract_value_from(*args)
      options = args.extract_options!
      attribute_names = args

      @attributes_to_extract = attributes_to_extract + Array(attribute_names)
      @collections_to_extract = collections_to_extract + Array(options[:collections])
    end
  end

  included do
    @attributes_to_extract = []
    @collections_to_extract = []

    def self.attributes_to_extract
      instance_variable_get(:@attributes_to_extract)
    end

    def self.collections_to_extract
      instance_variable_get(:@collections_to_extract)
    end
  end

  private

  def values_for_attributes(options = {})
    attributes_to_extract = self.class.attributes_to_extract

    result = attributes_to_extract.map do |attribute_name|
      [attribute_name, send(attribute_name)]
    end

    result = result.to_h.compact
    if options[:reject_blanks]
      result.reject! { |_attribute_name, value| value.blank? }
    end

    result
  end

  def values_for_collections(options = {})
    result = {}
    self.class.collections_to_extract.each do |collection_name|
      values = []
      send(collection_name).each do |item|
        value = item.value(options)
        values << value unless value.blank? && options[:reject_blanks]
      end
      result[collection_name] = values unless values.empty?
    end
    result
  end
end
