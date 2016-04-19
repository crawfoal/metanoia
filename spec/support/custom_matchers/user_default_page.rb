RSpec::Matchers.define :be_user_default_page do
  match do |actual|
    actual.has_selector? '.gyms.index'
  end
end
