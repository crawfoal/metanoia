RSpec::Matchers.define :show_flash_with do |expected_message, expected_style = nil|
  flash_selector =
    case expected_style
    when nil then 'div[class^="flash"]'
    else "div.flash-#{expected_style}"
    end

  match do |actual|
    actual.has_selector?(flash_selector, text: expected_message)
  end
end
