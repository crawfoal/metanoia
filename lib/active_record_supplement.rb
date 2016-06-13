module ActiveRecordSupplement
  def pluck(*attribute_names)
    [] << Array(attribute_names).inject([]) do |result, attribute_name|
      result + [attributes[attribute_name.to_s]]
    end
  end
end
