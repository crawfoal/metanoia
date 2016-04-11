RSpec::Matchers.define :include_errors do
  match do |actual|
    actual.include? 'error'
  end
end
