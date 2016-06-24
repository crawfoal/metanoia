RSpec::Matchers.define :show_one_climb do |options = {}|
  match do |actual|
    actual.has_selector?('#climbs a', options.merge(count: 1))
  end
end
