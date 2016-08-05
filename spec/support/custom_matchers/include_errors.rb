RSpec::Matchers.define :include_errors do
  match do |actual|
    if actual.respond_to? :has_selector?
      actual.has_selector? '#error_explanation'
    else
      actual.include? "We couldn't save your changes due to the following error"
    end
  end
end
