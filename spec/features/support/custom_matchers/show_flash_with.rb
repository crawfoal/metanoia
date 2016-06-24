RSpec::Matchers.define :show_flash_with do |expected_message, expected_style = nil|
  flash_selector =
    if expected_style.present?
      "div.flash-#{expected_style}"
    else
      'div[class^="flash"]'
    end

  match do |actual|
    actual.has_selector?(flash_selector, text: expected_message)
  end
end
