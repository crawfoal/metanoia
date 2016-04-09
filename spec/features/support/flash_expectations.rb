RSpec::Matchers.define :have_flash_with_content do |expected|
  match do |actual|
    unless actual.respond_to? :find
      raise "Expected #{actual} to respond to `find` but it didn't. This method is typically implemented by Capybara."
    end
    actual.find('div[class*="flash"]').has_content? expected
  end
end
