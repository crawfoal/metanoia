RSpec::Matchers.define :implement_form_interface do
  interface_methods = [
    :name,
    :errors,
    :persisted?,
    :model_name,
    :to_key,
    :to_model
  ]

  match do |actual|
    expect(actual).to respond_to *interface_methods
  end

  failure_message do |actual|
    "expected #{actual} to respond to #{interface_methods.to_sentence}"
  end
end
