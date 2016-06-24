RSpec::Matchers.define :show_climbs do |options = {}|
  match do |actual|
    actual.has_selector?('#climbs a', options)
  end
end
